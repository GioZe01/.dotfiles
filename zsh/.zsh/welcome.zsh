# Welcome message for new terminals
# Shows helpful i3 keybinding reminders

# Only show welcome message in interactive shells, not in tmux panes after the first
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════╗
║          Welcome to i3 + Zsh + Tmux!                      ║
╚═══════════════════════════════════════════════════════════╝

🔑 i3 Keybindings (⊞ = Windows Key):
   ⊞ + Enter       = New terminal
   ⊞ + d           = App launcher
   ⊞ + h/j/k/l     = Navigate windows (vim-style)
   ⊞ + 1-9         = Switch workspace
   ⊞ + Shift + q   = Close window

🖥️  Multi-Monitor:
   ⊞ + Ctrl + h/l  = Move workspace to monitor
   ⊞ + p           = Monitor configuration

⌨️  Terminal (Alacritty):
   Ctrl+C / Ctrl+V = Copy/Paste (works!)

📚 Full keybindings: cat ~/.dotfiles/I3_KEYBINDINGS.md

EOF
fi
