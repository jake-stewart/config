# vi emulation
KEYTIMEOUT=1
bindkey -v

# prompt (aesthetic)
PROMPT="%d $ "

show_title() {
    print -Pn "\e]2;zsh (%~)\a"
}

# show newline after every command except first & clear
skip_precmd() {
    precmd () {
        show_title
        precmd() {
            echo
            show_title
        }
    }
}
skip_precmd
alias clear="skip_precmd; clear"

# case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# add ~/.bin to path
[[ -d $HOME/.bin ]] && \
    export PATH="$HOME/.bin:$PATH"

cdls() {
    test -z "$1" && cd || cd "$1"
    ls --color=auto
}

# aliases
alias ls="ls --color=auto"
# alias cd="cdls"

# node version manager
# this takes forever to load, so only load it when it's called
nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    nvm $@
}

# automatically start tmux and attach/create
if command -v tmux &> /dev/null \
    && [ -n "$PS1" ] \
    && [[ ! "$TERM" =~ screen ]] \
    && [[ ! "$TERM" =~ tmux ]] \
    && [ -z "$TMUX" ]
then
    exec $(tmux a 2>/dev/null || tmux)
fi
