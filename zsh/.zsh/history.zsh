# Zsh history configuration

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# History options (also set in options.zsh, but explicit here)
setopt APPEND_HISTORY           # Append to history file
setopt EXTENDED_HISTORY         # Write timestamp
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicates first
setopt HIST_FIND_NO_DUPS        # Don't show duplicates in search
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicates
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_SPACE        # Don't record commands with leading space
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt HIST_SAVE_NO_DUPS        # Don't save duplicates
setopt HIST_VERIFY              # Show command before executing from history
setopt SHARE_HISTORY            # Share history between sessions
