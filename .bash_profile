export LSCOLORS=gxfxcxdxbxegedabagacad

# ログインシェル (ssh 等) でも alias / fzf 関数を読む
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# FZF 関数群は .shell_fzf に移動し、.bashrc から読むようにした
# (ここに書くと非ログインの bash で fbr などが未定義になるため)

[[ -s "/Users/yusukeohno/.gvm/scripts/gvm" ]] && source "/Users/yusukeohno/.gvm/scripts/gvm"
