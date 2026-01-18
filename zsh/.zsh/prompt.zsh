# Zsh prompt configuration
# Simple custom prompt (used if Oh My Zsh is not installed)

# Only set custom prompt if not using Oh My Zsh
if [ -z "$ZSH" ]; then
    # Enable prompt substitution
    setopt PROMPT_SUBST

    # Load vcs_info for git integration
    autoload -Uz vcs_info
    precmd() { vcs_info }

    # Git branch info
    zstyle ':vcs_info:git:*' formats ' (%b)'

    # Define prompt
    # Format: [user@host:directory] (git-branch)
    # $ for regular user, # for root
    PROMPT='%B%F{blue}[%F{green}%n%F{blue}@%F{cyan}%m%F{blue}:%F{yellow}%~%F{blue}]%f%b%F{red}${vcs_info_msg_0_}%f
%# '

    # Right prompt with time
    RPROMPT='%F{gray}%*%f'
fi

# Show virtual environment in prompt
if [ -n "$VIRTUAL_ENV" ]; then
    export PS1="($(basename $VIRTUAL_ENV)) $PS1"
fi
