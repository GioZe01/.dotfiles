# Zsh keybindings

# Use emacs-style keybindings
bindkey -e

# History search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# Line navigation
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' backward-kill-line
bindkey '^W' backward-kill-word

# Word navigation
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^[[1;5D' backward-word     # Ctrl+Left

# Delete key
bindkey '^[[3~' delete-char

# Home and End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Clear screen
bindkey '^L' clear-screen

# Accept autosuggestion (if zsh-autosuggestions is installed)
bindkey '^ ' autosuggest-accept     # Ctrl+Space
