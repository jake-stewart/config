# add ~/.bin to path
[[ -d $HOME/.bin ]] && \
    export PATH="$HOME/.bin:$PATH"

# history config
HISTCONTROL=ignoreboth  # ignore duplicate history & indentation
shopt -s histappend     # append to history file, dont overwrite
HISTSIZE=1000
HISTFILESIZE=2000

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# add newline after every command, except clear
PROMPT_COMMAND="export PROMPT_COMMAND=echo"
alias clear='PROMPT_COMMAND="export PROMPT_COMMAND=echo"; clear'

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias py=python3

# apply dircolors
if [[ -f "$HOME/.dir_colors" ]]; then
    eval $(dircolors -b $HOME/.dir_colors)
fi

# automatically start tmux and attach/create
if command -v tmux &> /dev/null \
    && [ -n "$PS1" ] \
    && [[ ! "$TERM" =~ screen ]] \
    && [[ ! "$TERM" =~ tmux ]] \
    && [ -z "$TMUX" ]
then
    exec $(tmux a 2>/dev/null || tmux)
fi
