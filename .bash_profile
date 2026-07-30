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

# start docker container
function fdocup() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'starting container...'
    docker start ${container}
  fi
}

# stop docker container
function fdocdown() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'stopping container...'
    docker stop ${container}
  fi
}
##########################################################

[[ -s "/Users/yusukeohno/.gvm/scripts/gvm" ]] && source "/Users/yusukeohno/.gvm/scripts/gvm"
