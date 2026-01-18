# Zsh configuration
# Modular setup - sources files from ~/.zsh/

# Path to oh-my-zsh installation (if installed)
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh theme (if using Oh My Zsh)
ZSH_THEME="robbyrussell"

# Oh My Zsh plugins (if using Oh My Zsh)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
)

# Load Oh My Zsh if installed
if [ -d "$ZSH" ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Load custom zsh modules
ZSH_CONFIG_DIR="$HOME/.zsh"

if [ -d "$ZSH_CONFIG_DIR" ]; then
    # Load in specific order
    [ -f "$ZSH_CONFIG_DIR/options.zsh" ] && source "$ZSH_CONFIG_DIR/options.zsh"
    [ -f "$ZSH_CONFIG_DIR/aliases.zsh" ] && source "$ZSH_CONFIG_DIR/aliases.zsh"
    [ -f "$ZSH_CONFIG_DIR/functions.zsh" ] && source "$ZSH_CONFIG_DIR/functions.zsh"
    [ -f "$ZSH_CONFIG_DIR/keybindings.zsh" ] && source "$ZSH_CONFIG_DIR/keybindings.zsh"
    [ -f "$ZSH_CONFIG_DIR/prompt.zsh" ] && source "$ZSH_CONFIG_DIR/prompt.zsh"
    [ -f "$ZSH_CONFIG_DIR/completion.zsh" ] && source "$ZSH_CONFIG_DIR/completion.zsh"
    [ -f "$ZSH_CONFIG_DIR/history.zsh" ] && source "$ZSH_CONFIG_DIR/history.zsh"
    [ -f "$ZSH_CONFIG_DIR/welcome.zsh" ] && source "$ZSH_CONFIG_DIR/welcome.zsh"
fi

# FZF configuration
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# User-specific environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.local/bin:$PATH"

# Lavoro project directory
export LAVORO_DIR="$HOME/Documents/Lavoro"

# Auto-start tmux if not already in tmux and not in SSH
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]; then
    # If no tmux sessions exist, create a new one named "main"
    if ! tmux has-session 2>/dev/null; then
        tmux new-session -s main
    else
        # Attach to existing session
        tmux attach-session
    fi
fi
