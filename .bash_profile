export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=/Applications/MacVim.app/Contents/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:$PATH
export PATH=$HOME/.jenv/bin:$PATH
export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH

eval "$(jenv init -)"
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
#fbr - checkout git branch (including remote branches)
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
##########################################################


function kotc(){ kotlinc $1 -include-runtime -d ${1//.kt/.jar};}
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
tmux_automatically_attach_session
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/yusukeohno/.sdkman"
[[ -s "/Users/yusukeohno/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/yusukeohno/.sdkman/bin/sdkman-init.sh"
