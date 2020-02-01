# Alias設定
alias ll='ls -lah'
alias ls='ls -G'
alias twl='tw -tl -id'
alias tw='tw -id'
alias doc='docker'
alias grep='grep --color=auto'
alias ck='pgrep Chrome | xargs kill'
alias tx='exit'
alias doco='docker-compose'
alias javac='java -jar'
alias vio='vim -u NONE -N'
alias vif='mvim -v $(fzf)'
alias vim='mvim -v'
# alias vim='gvim --remote-tab-silent'
alias t-kill='tmux kill-server'
# java9以降読み込めないclassが存在するらしい
# export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
