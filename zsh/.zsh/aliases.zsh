# Zsh aliases

# General aliases
alias c='clear'
alias q='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases with colors
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'

# grep with colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# File operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Editor aliases
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

# Git aliases (if not using Oh My Zsh git plugin)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# System updates
alias update='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y && sudo apt autoclean'

# Python aliases
alias py='python3'
alias python='python3'
alias pip='pip3'

# Virtual environment
alias venv='python3 -m venv venv'
alias activate='source venv/bin/activate'

# Tmux aliases
alias ta='tmux attach'
alias tad='tmux attach -d'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'

# Directory navigation for common locations
alias dotfiles='cd ~/.dotfiles'
alias lavoro='cd $LAVORO_DIR'

# Work with editor shortcut
alias worke='work -e'

# fd-find compatibility (Ubuntu installs it as fdfind)
if command -v fdfind &> /dev/null; then
    alias fd='fdfind'
fi

# bat (cat with syntax highlighting) if installed
if command -v batcat &> /dev/null; then
    alias bat='batcat'
    alias cat='batcat --paging=never'
fi

# Quick file finding
alias f='find . -name'

# Disk usage
alias du='du -h'
alias df='df -h'

# Process management
alias ps='ps aux'
alias psg='ps aux | grep'

# Network
alias ports='netstat -tulanp'

# System info
alias sysinfo='inxi -Fxz'

# Audio controls
alias vol='amixer get Master | grep -o "[0-9]*%"'
alias vol-up='amixer set Master 5%+'
alias vol-down='amixer set Master 5%-'
alias vol-mute='amixer set Master toggle'
alias vol-50='amixer set Master 50%'
alias vol-80='amixer set Master 80%'
alias vol-100='amixer set Master 100%'
