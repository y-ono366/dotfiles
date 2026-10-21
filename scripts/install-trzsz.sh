#!/usr/bin/env bash
# install-trzsz.sh — trzsz (trz / tsz / trzsz) を入れる冪等スクリプト
#
# 使い方:
#   scripts/install-trzsz.sh            # 未導入なら入れる
#   scripts/install-trzsz.sh --force    # 入っていても入れ直す
#   scripts/install-trzsz.sh --auto     # .zshrc からの自動呼び出し用（失敗後 24h は黙ってスキップ）
#   ssh host 'bash -s' < scripts/install-trzsz.sh   # dotfiles の無いホストに流し込む
#
# 入れ方:
#   macOS で brew が使えれば  brew install trzsz-go
#   それ以外は GitHub release の tarball を sha256 検証して
#   root なら /usr/local/bin、それ以外は ~/.local/bin に配置
#
# 環境変数: TRZSZ_VERSION（既定 1.2.0）
set -Eeuo pipefail

TRZSZ_VERSION="${TRZSZ_VERSION:-1.2.0}"
MARKER_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles"
MARKER="$MARKER_DIR/trzsz-install-failed"
AUTO=0
FORCE=0

usage() {
  cat <<'USAGE'
usage: install-trzsz.sh [--auto] [--force]
  --auto   .zshrc からの自動呼び出し用。直近 24h に失敗していれば何もしない
  --force  入っていても入れ直す
env: TRZSZ_VERSION (default 1.2.0)
USAGE
}

for a in "$@"; do
  case "$a" in
    --auto)  AUTO=1 ;;
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown option: $a" >&2; usage >&2; exit 2 ;;
  esac
done

log() { printf '[install-trzsz] %s\n' "$*"; }
trz_version() { "$1" -v 2>&1 | head -1 || true; }

if [[ $FORCE -eq 0 ]] && command -v trz >/dev/null 2>&1; then
  [[ $AUTO -eq 1 ]] || log "already installed: $(command -v trz) ($(trz_version trz))"
  exit 0
fi

# --auto: 直近 24h に失敗していたら何もしない（ネットワーク無し等で毎回待たされないように）
if [[ $AUTO -eq 1 && -f "$MARKER" ]] && [[ -n "$(find "$MARKER" -mmin -1440 2>/dev/null)" ]]; then
  exit 0
fi

TMP=""
INSTALLED_BIN=""   # インストール後に存在するはずの trz のパス
cleanup() { [[ -n "$TMP" ]] && rm -rf "$TMP"; return 0; }
mark_failed() {
  cleanup
  mkdir -p "$MARKER_DIR" 2>/dev/null && date > "$MARKER" || true
  log "failed. 手動で再試行: ~/dotfiles/scripts/install-trzsz.sh"
}
trap mark_failed ERR

find_brew() {
  if command -v brew >/dev/null 2>&1; then command -v brew; return 0; fi
  local b
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $b ]] && { echo "$b"; return 0; }
  done
  return 1
}

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | awk '{print $1}'
  else shasum -a 256 "$1" | awk '{print $1}'; fi
}

install_via_brew() {
  local brew="$1"
  INSTALLED_BIN="$(dirname "$brew")/trz"
  log "$brew install trzsz-go"
  # brew は無関係な cleanup 等で非0を返すことがあるので、成否は最後に trz の有無で判定する
  HOMEBREW_NO_AUTO_UPDATE=1 "$brew" install trzsz-go || log "brew returned non-zero; checking the result anyway"
}

install_via_tarball() {
  local os arch dest tarball base expected actual f src
  case "$(uname -s)" in
    Darwin) os=macos ;;
    Linux)  os=linux ;;
    *) log "unsupported OS: $(uname -s)"; return 1 ;;
  esac
  case "$(uname -m)" in
    arm64|aarch64) arch=aarch64 ;;
    x86_64|amd64)  arch=x86_64 ;;
    *) log "unsupported arch: $(uname -m)"; return 1 ;;
  esac
  if [[ $(id -u) -eq 0 ]]; then dest=/usr/local/bin; else dest="$HOME/.local/bin"; fi
  INSTALLED_BIN="$dest/trz"
  tarball="trzsz_${TRZSZ_VERSION}_${os}_${arch}.tar.gz"
  base="https://github.com/trzsz/trzsz-go/releases/download/v${TRZSZ_VERSION}"
  TMP="$(mktemp -d)"

  log "download $base/$tarball"
  curl -fsSL --connect-timeout 10 --max-time 120 -o "$TMP/$tarball" "$base/$tarball"
  curl -fsSL --connect-timeout 10 --max-time 60 -o "$TMP/checksums.txt" "$base/trzsz_${TRZSZ_VERSION}_checksums.txt"

  expected="$(grep " ${tarball}\$" "$TMP/checksums.txt" | awk '{print $1}')"
  actual="$(sha256_of "$TMP/$tarball")"
  if [[ -z "$expected" || "$expected" != "$actual" ]]; then
    log "sha256 mismatch for $tarball (expected=${expected:-?} actual=$actual)"
    return 1
  fi

  tar -xzf "$TMP/$tarball" -C "$TMP"
  mkdir -p "$dest"
  for f in trz tsz trzsz; do
    src="$(find "$TMP" -type f -name "$f" | head -1)"
    [[ -n "$src" ]] || { log "$f not found in $tarball"; return 1; }
    install -m 755 "$src" "$dest/$f"
  done
  log "installed trz tsz trzsz -> $dest"
  case ":$PATH:" in *":$dest:"*) ;; *) log "note: $dest is not in PATH" ;; esac
  cleanup; TMP=""
}

if [[ "$(uname -s)" == Darwin ]] && brew_bin="$(find_brew)"; then
  install_via_brew "$brew_bin"
else
  install_via_tarball
fi

if [[ -x "$INSTALLED_BIN" ]]; then
  rm -f "$MARKER" 2>/dev/null || true
  log "done: $INSTALLED_BIN ($(trz_version "$INSTALLED_BIN"))"
else
  log "$INSTALLED_BIN not found after install"
  false   # -> ERR trap
fi
