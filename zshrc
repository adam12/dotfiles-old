### Function paths
fpath=(~/code/dotfiles/zsh/functions $fpath)

### Sources
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
source /usr/local/share/gem_home/gem_home.sh

### Variables
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
export EDITOR=vim
export LESS="-FRSX"         # A better less
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS=Gxfxcxdxbxegedabagacad
#export PAGER=less

typeset -U path # Ensure unique entries in path
path=(/usr/local/bin /usr/local/sbin /usr/local/share/npm/bin . $path)

### Aliases
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls -G'
alias redis.server='redis-server /usr/local/etc/redis.conf'
alias pg.server='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
alias rabbitmq.server='rabbitmq-server'
alias mongodb.server='mongod'
alias influxdb.server='influxdb -config=/usr/local/etc/influxdb.conf'
alias memcache.server='/usr/local/opt/memcached/bin/memcached'
alias beanstalk.server='beanstalkd'
alias bower='noglob bower'
alias gst='git status'
alias rake='noglob rake'        # necessary to make rake work inside of zsh
alias ri='noglob ri -f ansi'    # search Ruby documentation

### Functions
# compressed file expander (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
function extract() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar x $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

function gzipcheck() {
    curl -I -H "Accept-Encoding: gzip,deflate" --silent $@ | grep --color "Content-Encoding:"
}

function reload() {
    exec "${SHELL}" "$@"
}

function copy_function() {
    test -n "$(declare -f $1)" || return
    eval "${_/$1/$2}"
}

function rename_function() {
    copy_function $@ || return
    unset -f $1
}

rename_function gem_home_push gem_home_push2
rename_function gem_home_pop gem_home_pop2

function gem_home_push() {
    export GEM_HOME_PUSHED=$1
    gem_home_push2 "$@"
}

function gem_home_pop() {
    unset GEM_HOME_PUSHED
    gem_home_pop2 "$@"
}


# coloured manuals
function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

### Hooks
eval "$(hub alias -s)"
eval "$(direnv hook $0)"
eval "$(npm completion 2>/dev/null)"

### ZSH modules
autoload -U colors
autoload -U zargs           # zargs, as a alternative to find -exec and xargs
autoload -U zcalc           # calculator
autoload -U zmv             # zmc, a command for renaming files by means of shell patterns
autoload -U compinit        # command completion
autoload -U promptinit      # coloured prompts
autoload -U run-help        # no built-in support for the help command
autoload run-help-git run-help svn run-help-svk

### ZSH options
compinit                    # command completion
promptinit                  # coloured prompts
colors                      # enable colours
setopt completealiases      # autocomplete command line switches for aliases
setopt extended_history     # save each commands timestamp and duration in the history file
setopt hist_verify          # after successful history completion, perform history expansion and reload line into buffer
setopt inc_append_history   # append history log as it happens, not at shell exit
setopt hist_ignore_dups     # prevent putting duplicate lines in history
setopt hist_ignore_space    # prevent record in history if prepended with at least one space
setopt share_history        #
unalias run-help            # we need run-help elsewhere
alias help=run-help         # alias run-help to help
setopt extendedglob         # add lots of glob goodies
setopt interactivecomments  # ignore lines prefixed with '#'
setopt noflowcontrol        # disable flow control
setopt promptsubst          # command substition in prompt (and parameter expansion and arithmetic expansion)

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Use my prompt
prompt adam

### Other
# Go config
export GOPATH=~/code/go
export PATH=$GOPATH/bin:$PATH
eval $(go env | grep GOROOT)
export PATH=$GOROOT/bin:$PATH

# complete on installed rubies
_chruby() { compadd $(chruby | tr -d '* ') }
compdef _chruby chruby

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# vim:sw=4:ts=4:sts=4:et:
