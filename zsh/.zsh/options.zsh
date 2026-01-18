# Zsh options

# Directory navigation
setopt AUTO_CD              # Auto cd to directory without cd command
setopt AUTO_PUSHD           # Push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_SILENT         # Don't print directory stack

# Completion
setopt ALWAYS_TO_END        # Move cursor to end after completion
setopt AUTO_MENU            # Show completion menu on tab
setopt COMPLETE_IN_WORD     # Allow completion from within a word
setopt LIST_PACKED          # Smaller completion menu

# History
setopt EXTENDED_HISTORY     # Write timestamp to history
setopt HIST_IGNORE_DUPS     # Ignore duplicate commands
setopt HIST_IGNORE_SPACE    # Ignore commands starting with space
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks
setopt SHARE_HISTORY        # Share history between sessions

# Input/Output
setopt CORRECT              # Correct spelling of commands
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell

# Globbing
setopt EXTENDED_GLOB        # Use extended globbing
setopt GLOB_DOTS            # Include dotfiles in globbing

# Jobs
setopt AUTO_RESUME          # Resume suspended jobs with command name
setopt NOTIFY               # Report status of background jobs immediately

# Colors
autoload -U colors && colors
