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
alias vif='vim $(fzf)'
# alias vim='gvim --remote-tab-silent'
alias t-kill='tmux kill-server'
# java9以降読み込めないclassが存在するらしい
# export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Users/yusukeohno/.nodebrew/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash