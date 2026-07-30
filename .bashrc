export PATH=/usr/local/bin:$PATH
export PATH=$PATH:./node_modules/.bin
# macOS 専用パス (Homebrew PHP)
if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=/usr/local/Cellar/php@7.4/7.4.13_1/bin:$PATH
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
# mvim (MacVim) は macOS のみ。Linux では素の vim を使う
if [[ "$OSTYPE" == darwin* ]]; then
  alias vif='mvim -v $(fzf)'
  alias vim='mvim -v'
else
  alias vif='vim $(fzf)'
fi
# alias vim='gvim --remote-tab-silent'
alias t-kill='tmux kill-server'
# java9以降読み込めないclassが存在するらしい
# export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf 関数群 (fbr/fbrm/fmgn/fd/fda/fdocup/fdocdown)
# シンボリックリンク済みなら $HOME、未リンクならリポジトリ内を読む
for _fzf_rc in "$HOME/.shell_fzf" "$HOME/dotfiles/.shell_fzf"; do
  if [ -f "$_fzf_rc" ]; then . "$_fzf_rc"; break; fi
done
unset _fzf_rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
