export PATH=/usr/local/bin:$PATH
export PATH=$PATH:./node_modules/.bin
# macOS 専用パス (Homebrew PHP / composer / Android SDK)
if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=/usr/local/Cellar/php@7.4/7.4.13_1/bin:$PATH
  export PATH=$HOME/.composer/vendor/bin:$PATH
  export ANDROID_SDK=$HOME/Library/Android/sdk
  export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
fi


# Alias設定
alias ll='ls -lah'
# -G は BSD ls では色付け、GNU ls ではグループ列の抑制と意味が違う
if [[ "$OSTYPE" == darwin* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias twl='tw -tl -id'
alias tw='tw -id'
alias doc='docker'
alias grep='grep --color=auto'
alias ck='pgrep Chrome | xargs kill'
alias tx='exit'
alias doco='docker-compose'
alias javac='java -jar'
alias vio='vim -u NONE -N'
alias vif='vim -v $(fzf)'
alias vim='vim -v'
# alias vim='gvim --remote-tab-silent'
alias t-kill='tmux kill-server'
alias ide='tmux split-window -h -p 85 && tmux split-window -v -p 15'

# tmux セッション操作（引数省略時は claude）
tc()  { tmux new-session -A -s "${1:-claude}"; }   # 作成 or 既存にアタッチ
tca() { tmux attach -t "${1:-claude}"; }           # アタッチのみ
tck() { tmux kill-session -t "${1:-claude}"; }     # 指定セッション終了
alias tcl='tmux ls'                                # セッション一覧
alias awsp="source _awsp"
# java9以降読み込めないclassが存在するらしい
# export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf 関数群 (fbr/fbrm/fmgn/fd/fda/fdocup/fdocdown)
# シンボリックリンク済みなら $HOME、未リンクならリポジトリ内を読む
for _fzf_rc in "$HOME/.shell_fzf" "$HOME/dotfiles/.shell_fzf"; do
  if [ -f "$_fzf_rc" ]; then . "$_fzf_rc"; break; fi
done
unset _fzf_rc
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# OpenClaw Completion
[ -f "/Users/claudecode/.openclaw/completions/openclaw.zsh" ] && \
  source "/Users/claudecode/.openclaw/completions/openclaw.zsh"
