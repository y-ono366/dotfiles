if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"
