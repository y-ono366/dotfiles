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
echo "${fg_bold[red]} ______ _   _   ___  _   _    _   _      _   _  __      __  _   __       __ ${reset_color}"
echo "${fg_bold[red]}|  ____| | | |/ ___|| | / /  | | |  \   | | |/  \ \    / / | | |  \     /  |${reset_color}"
echo "${fg_bold[red]}| |____| | | | |    | |/ /   | | | \ \  | |      \ \  / /  | | | \ \   /   |${reset_color}"
echo "${fg_bold[red]}|  ____| | | | |    |   |    | | | |\ \ | |       \ \/ /   | | | |\ \ / /| |${reset_color}"
echo "${fg_bold[red]}| |    | |_| | |___ | |\ \   | | | | \ \| |        \  /    | | | | \   / | |${reset_color}"
echo "${fg_bold[red]}|_|     \___/ \____||_| \_\  |_| |_|  \ __|         \/     |_| |_|  \_/  |_|${reset_color}"
