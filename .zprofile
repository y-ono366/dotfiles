export LSCOLORS=gxfxcxdxbxegedabagacad

# zsh は対話シェルで .zshrc を自動で読むため、ここから source しない
# (二重読み込みで PATH が重複するのを避ける)

# FZF 関数群は .shell_fzf に移動し、.zshrc から読むようにした

[[ -s "/Users/yusukeohno/.gvm/scripts/gvm" ]] && source "/Users/yusukeohno/.gvm/scripts/gvm"

[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
