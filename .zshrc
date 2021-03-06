export PATH=/usr/local/bin:$PATH
export PATH=$PATH:./node_modules/.bin

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
alias vif='vim -v $(fzf)'
alias vim='vim -v'
# alias vim='gvim --remote-tab-silent'
alias t-kill='tmux kill-server'
alias ide='tmux split-window -h -p 85 && tmux split-window -v -p 15'
# java9以降読み込めないclassが存在するらしい
# export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
