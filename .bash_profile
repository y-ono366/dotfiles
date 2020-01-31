export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/2.5.0/bin:$PATH
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

export LSCOLORS=gxfxcxdxbxegedabagacad

########################   FZF   #########################
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
export FZF_DEFAULT_COMMAND='ag -g ""'
#fbr - checkout git branch
function fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function fmgn(){
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git merge --no-ff $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

#fbr - checkout git branch (including remote branches)
function fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fd - cd to selected directory
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

function f-docker-start() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'starting container...'
    docker start ${container}
  fi
}
function f-docker-stop() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'stopping container...'
    docker stop ${container}
  fi
}
##########################################################

function jq-l(){ jq '.'${1}' | select( .'${2}' | contains("'${3}'"))';}
function kotc(){ kotlinc $1 -include-runtime -d ${1//.kt/.jar};}
function fg(){
    find . -name "${1}" | xargs grep -s $2
}
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} ______ _   _   ___  _   _    _   _      _   _  _______ __    ____   ____    __     ${reset_color}"
            echo "${fg_bold[red]}|  ____| | | |/ ___|| | / /  | | |  \   | | |/ |__   __|  \  /  | | | |\ \  / /     ${reset_color}"
            echo "${fg_bold[red]}| |____| | | | |    | |/ /   | | | \ \  | |       | |  |   \/   | | | | \ \/ /      ${reset_color}"
            echo "${fg_bold[red]}|  ____| | | | |    |   |    | | | |\ \ | |       | |  | |\  /| | | | |  \  /       ${reset_color}"
            echo "${fg_bold[red]}| |    | |_| | |___ | |\ \   | | | | \ \| |       | |  | | \/ | | |_| | / /\ \      ${reset_color}"
            echo "${fg_bold[red]}|_|     \___/ \____||_| \_\  |_| |_|  \ __|       |_|  |_|    |_|\___/ /_/  \_\     ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
if type "tmux" > /dev/null 2>&1
then
tmux_automatically_attach_session
fi
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi
echo "${fg_bold[red]} ______ _   _   ___  _   _    _   _      _   _  __      __  _   __       __ ${reset_color}"
echo "${fg_bold[red]}|  ____| | | |/ ___|| | / /  | | |  \   | | |/  \ \    / / | | |  \     /  |${reset_color}"
echo "${fg_bold[red]}| |____| | | | |    | |/ /   | | | \ \  | |      \ \  / /  | | | \ \   /   |${reset_color}"
echo "${fg_bold[red]}|  ____| | | | |    |   |    | | | |\ \ | |       \ \/ /   | | | |\ \ / /| |${reset_color}"
echo "${fg_bold[red]}| |    | |_| | |___ | |\ \   | | | | \ \| |        \  /    | | | | \   / | |${reset_color}"
echo "${fg_bold[red]}|_|     \___/ \____||_| \_\  |_| |_|  \ __|         \/     |_| |_|  \_/  |_|${reset_color}"

