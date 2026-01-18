# Zsh - Complete Command Reference

## Core Concepts
- **Shell**: Command interpreter for Unix systems
- **Oh My Zsh**: Framework with plugins and themes
- **Aliases**: Shortcuts for common commands
- **Functions**: Custom shell functions for complex tasks
- **Completion**: Tab completion for commands and arguments

---

## Custom Functions (Lavoro Project Management)

### Quick Navigation and Environment Activation

#### Main Work Function
```bash
work <project-name>
```
**Description**: Navigate to Lavoro project and activate virtual environment.

**Examples**:
```bash
# Navigate to hyperdnabert and activate venv
work hyperdnabert

# Navigate to anamnesis and activate venv
work anamnesis

# Navigate to prism_sr_hdnabert and activate venv
work prism_sr_hdnabert

# Navigate to cgkt and activate venv
work cgkt
```

**What it does**:
1. Changes directory to `~/Documents/Lavoro/<project-name>`
2. Activates the Python virtual environment (venv)
3. Shows current Python version and location

#### Quick Aliases for Lavoro Projects
```bash
work-hdb        # Shortcut for: work hyperdnabert
work-ana        # Shortcut for: work anamnesis
work-prism      # Shortcut for: work prism_sr_hdnabert
work-cgkt       # Shortcut for: work cgkt
```

**Example Usage**:
```bash
# Instead of typing the full project name
work-hdb        # Quick access to hyperdnabert

# Then you can immediately run commands
python train.py
pytest tests/
```

### Virtual Environment Management

#### Recreate Virtual Environment
```bash
recreate-venv
```
**Description**: Completely recreate the Python virtual environment for the current project.

**What it does**:
1. Deactivates current venv if active
2. Deletes existing venv directory
3. Creates new venv with current Python version
4. Upgrades pip to latest version
5. Installs project in editable mode (`pip install -e .`)

**When to use**:
- Virtual environment is broken or corrupted
- Need to upgrade Python version for project
- Dependencies are conflicting
- After changing `pyproject.toml` or `setup.py`

**Example Workflow**:
```bash
work-hdb                # Navigate to project
recreate-venv           # Recreate broken venv
pip install pytest      # Install additional dev dependencies
pytest                  # Run tests
```

---

## Aliases

### Navigation
```bash
..              # cd ..
...             # cd ../..
....            # cd ../../..
.....           # cd ../../../..

# List files
ls              # ls --color=auto
ll              # ls -alF (detailed list)
la              # ls -A (all files except . and ..)
l               # ls -CF (columns with indicators)
```

### Git Shortcuts
```bash
g               # git
ga              # git add
gaa             # git add --all
gc              # git commit -v
gcm             # git commit -m
gco             # git checkout
gcb             # git checkout -b
gd              # git diff
gds             # git diff --staged
gl              # git pull
gp              # git push
gst             # git status
glog            # git log --oneline --decorate --graph
```

### Python and Virtual Environments
```bash
py              # python3
pip             # python3 -m pip
ipy             # ipython
jn              # jupyter notebook
jl              # jupyter lab

# Virtual environment
activate        # source venv/bin/activate
deactivate      # deactivate venv
mkvenv          # python3 -m venv venv
```

### System Commands
```bash
h               # history
grep            # grep --color=auto
fgrep           # fgrep --color=auto
egrep           # egrep --color=auto

# Disk usage
df              # df -h
du              # du -h
```

### Process Management
```bash
psgrep          # ps aux | grep
killall         # killall -9
```

---

## Oh My Zsh

### Oh My Zsh Commands
```bash
# Update Oh My Zsh
omz update

# Check for updates
omz changelog

# Reload zsh configuration
omz reload

# List plugins
omz plugin list

# Enable plugin
omz plugin enable <plugin-name>

# Disable plugin
omz plugin disable <plugin-name>
```

### Enabled Plugins
1. **git**: Git aliases and completion
2. **zsh-autosuggestions**: Command suggestions from history
3. **zsh-syntax-highlighting**: Syntax highlighting as you type
4. **command-not-found**: Suggests package to install for unknown commands
5. **sudo**: Press ESC twice to add sudo to command
6. **history**: Enhanced history commands
7. **colored-man-pages**: Colorized man pages
8. **extract**: Universal archive extractor (`extract file.zip`)

### Plugin-Specific Commands

#### Git Plugin
```bash
gaa             # git add --all
gcmsg           # git commit -m
gco             # git checkout
gcb             # git checkout -b
gd              # git diff
gl              # git pull
gp              # git push
gst             # git status
glog            # git log --oneline --decorate --graph
grb             # git rebase
grbi            # git rebase -i
```

#### Extract Plugin
```bash
extract file.tar.gz         # Extract tar.gz
extract file.zip            # Extract zip
extract file.rar            # Extract rar
extract file.7z             # Extract 7z

# Works with: tar, gz, bz2, xz, zip, rar, 7z, deb, rpm
```

#### Sudo Plugin
```bash
# Type command, then press ESC twice
vim /etc/hosts
<ESC><ESC>                  # Becomes: sudo vim /etc/hosts
```

---

## History Management

### History Commands
```bash
# View history
history                     # Show all history
history 10                  # Show last 10 commands

# Search history
Ctrl+r                      # Reverse search (interactive)
history | grep "command"    # Search for specific command

# Execute from history
!123                        # Run command number 123
!!                          # Run last command
!$                          # Last argument of previous command
!^                          # First argument of previous command
!*                          # All arguments of previous command

# History substitution
^old^new                    # Replace old with new in last command
```

### History Configuration
```zsh
# In ~/.zsh/history.zsh
HISTSIZE=50000              # Lines kept in memory
SAVEHIST=50000              # Lines saved to file
HISTFILE=~/.zsh_history     # History file location

# Options enabled:
# - EXTENDED_HISTORY: Save timestamp
# - SHARE_HISTORY: Share across sessions
# - HIST_IGNORE_DUPS: Don't save duplicates
# - HIST_IGNORE_SPACE: Ignore commands starting with space
```

**Ignore command from history**:
```bash
# Add space before command
 secret-command              # Won't be saved in history
```

---

## Completion System

### Tab Completion
```bash
# Basic completion
cd Doc<TAB>                 # Completes to Documents/

# Multiple matches
cd D<TAB>                   # Shows: Desktop/ Documents/ Downloads/
cd Do<TAB>                  # Narrows to: Documents/ Downloads/

# Command completion
git che<TAB>                # Completes to: git checkout

# File completion
nvim ~/.z<TAB>              # Shows: .zshrc .zsh/ .zsh_history
```

### Advanced Completion
```bash
# Completion with options
git checkout <TAB>          # Lists branches
git add <TAB>               # Lists modified files
cd <TAB>                    # Lists directories only

# Process completion
kill <TAB>                  # Lists running processes

# User completion
ssh <TAB>                   # Lists known SSH hosts

# Variable completion
echo $HO<TAB>               # Completes to $HOME
```

### Menu Selection
```bash
# Navigate completions with arrow keys
cd <TAB>
# Use arrow keys to select
# Press Enter to accept
# Press Ctrl+c to cancel
```

---

## Keybindings (Vi Mode)

### Normal Mode Navigation
```bash
# Enter command mode
ESC or Ctrl+[

# Movement
h                           # Left
j                           # Down (previous in history)
k                           # Up (next in history)
l                           # Right
w                           # Forward one word
b                           # Backward one word
0                           # Beginning of line
$                           # End of line

# Editing
x                           # Delete character
dd                          # Delete line
D                           # Delete to end of line
C                           # Change to end of line
i                           # Enter insert mode
a                           # Append (insert after cursor)
A                           # Append at end of line
I                           # Insert at beginning of line
```

### Insert Mode (Default)
```bash
Ctrl+a                      # Move to beginning of line
Ctrl+e                      # Move to end of line
Ctrl+k                      # Delete to end of line
Ctrl+u                      # Delete to beginning of line
Ctrl+w                      # Delete word backward
Ctrl+l                      # Clear screen
Ctrl+r                      # Reverse search history
Ctrl+z                      # Suspend current command (fg to resume)
```

---

## Directory Navigation

### Jump to Recent Directories
```bash
# Using directory stack
cd -                        # Go to previous directory
cd -2                       # Go to 2nd previous directory

# Directory stack commands
dirs                        # Show directory stack
pushd /path                 # Push directory and cd
popd                        # Pop directory and cd
```

### Autojump / Z
```bash
# After visiting directories, use z to jump
z hyperdnabert             # Jump to ~/Documents/Lavoro/hyperdnabert
z ana                      # Jump to ~/Documents/Lavoro/anamnesis
z dot                      # Jump to ~/.dotfiles

# List matches
z -l project               # List all matching directories
```

---

## Prompt Customization

### Prompt Information
```zsh
# Default prompt shows:
# username@hostname current-directory git-branch
# $

# Example:
gio@ubuntu ~/Documents/Lavoro/hyperdnabert (main)
$
```

### Git Integration in Prompt
```zsh
# Shows current branch
~/project (main)

# Shows dirty state
~/project (main *)          # Uncommitted changes
~/project (main +)          # Staged changes
~/project (main %)          # Untracked files
```

---

## Environment Variables

### Important Variables
```bash
# View variable
echo $HOME                  # /home/gio
echo $PATH                  # Executable search paths
echo $LAVORO_DIR            # /home/gio/Documents/Lavoro

# Set variable (temporary)
export MY_VAR="value"

# Set variable (permanent)
echo 'export MY_VAR="value"' >> ~/.zsh/options.zsh
source ~/.zshrc
```

### Common Variables
```bash
HOME                        # User home directory
USER                        # Current username
SHELL                       # Current shell
PATH                        # Executable search paths
EDITOR                      # Default text editor (nvim)
LANG                        # System language
LAVORO_DIR                  # Lavoro projects directory
VIRTUAL_ENV                 # Active Python venv path
```

---

## Globbing (Pattern Matching)

### Basic Globbing
```bash
# Wildcards
ls *.py                     # All Python files
ls test_*.py                # Files starting with test_
ls *test.py                 # Files ending with test.py
ls ?.txt                    # Single character match

# Recursive
ls **/*.py                  # All Python files recursively
```

### Advanced Globbing
```bash
# Modifiers
ls *.py(.)                  # Only files (not directories)
ls *(/)                     # Only directories
ls *(@)                     # Only symlinks
ls *(x)                     # Only executable files

# Sorting
ls *.py(om)                 # Sorted by modification time
ls *(oL)                    # Sorted by size
ls *(on)                    # Sorted by name

# Limiting
ls *(om[1,10])              # 10 most recently modified
```

---

## Redirection and Pipes

### Redirection
```bash
# Output redirection
command > file.txt          # Write output (overwrite)
command >> file.txt         # Append output
command 2> error.txt        # Write errors
command &> all.txt          # Write both output and errors

# Input redirection
command < input.txt         # Read from file
```

### Pipes
```bash
# Chain commands
cat file.txt | grep "pattern"
ls -la | grep "\.py$" | wc -l

# Tee (output to file and stdout)
echo "test" | tee file.txt

# Xargs (build command from input)
find . -name "*.pyc" | xargs rm
```

---

## Job Control

### Background Jobs
```bash
# Run in background
command &

# View jobs
jobs

# Bring to foreground
fg                          # Last job
fg %1                       # Job 1

# Send to background
bg                          # Continue last job in background
bg %1                       # Continue job 1 in background

# Suspend current job
Ctrl+z

# Kill job
kill %1
```

---

## Configuration Files

### Config File Structure
```bash
~/.zshrc                    # Main config (sources others)
~/.zsh/
  ├── aliases.zsh           # Command aliases
  ├── functions.zsh         # Custom functions (work, recreate-venv)
  ├── completion.zsh        # Completion settings
  ├── history.zsh           # History configuration
  ├── keybindings.zsh       # Key bindings
  ├── options.zsh           # Shell options
  ├── prompt.zsh            # Prompt customization
  └── welcome.zsh           # Welcome message and i3 help
```

### Reload Configuration
```bash
# Reload zshrc
source ~/.zshrc

# Or use alias
. ~/.zshrc

# Or restart shell
exec zsh
```

### Edit Configuration
```bash
# Edit main config
nvim ~/.zshrc

# Edit specific module
nvim ~/.zsh/aliases.zsh
nvim ~/.zsh/functions.zsh

# Edit and reload
nvim ~/.zshrc && source ~/.zshrc
```

---

## Workflow Examples

### Daily Development Workflow
```bash
# Morning: Start working on hyperdnabert
work-hdb                    # Navigate and activate venv

# Check git status
gst                         # git status

# Make changes
nvim src/model.py

# Run tests
pytest tests/

# If venv breaks
recreate-venv

# Commit changes
gaa                         # git add --all
gcmsg "Add new model layer" # git commit -m

# Push changes
gp                          # git push

# Switch to another project
work-ana                    # Switch to anamnesis
```

### Multi-Project Day
```bash
# Work on multiple projects in tmux windows
tmux new -s projects

# Window 0: hyperdnabert
work-hdb
nvim src/

Prefix c                    # New window

# Window 1: anamnesis
work-ana
python train.py

Prefix c                    # New window

# Window 2: prism
work-prism
pytest

# Switch between projects
Prefix 0                    # hyperdnabert
Prefix 1                    # anamnesis
Prefix 2                    # prism
```

### Virtual Environment Reset
```bash
# Project dependencies broken
work-hdb
recreate-venv               # Recreate venv

# Install dev dependencies
pip install pytest black flake8 mypy

# Verify installation
python -c "import torch; print(torch.__version__)"
pytest --version
```

---

## Advanced Features

### Suffix Aliases
```bash
# Open files with specific program based on extension
alias -s py=nvim            # nvim file.py → opens in nvim
alias -s txt=nvim
alias -s md=nvim
alias -s pdf=zathura
```

### Global Aliases
```bash
# Can be used anywhere in command
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'

# Usage
ps aux G python             # ps aux | grep python
dmesg L                     # dmesg | less
history H 20                # history | head 20
```

### Functions vs Aliases
```bash
# Alias (simple substitution)
alias ll='ls -alF'

# Function (can use arguments and logic)
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Usage
mkcd new-project            # Creates and enters directory
```

---

## Troubleshooting

### Shell Not Starting
```bash
# Check syntax errors
zsh -n ~/.zshrc

# Start with minimal config
zsh -f

# Check for conflicting plugins
# Comment out plugins in ~/.zshrc one by one
```

### Completion Not Working
```bash
# Rebuild completion cache
rm ~/.zcompdump
compinit

# Check completion system
autoload -Uz compinit && compinit
```

### History Not Saving
```bash
# Check history file permissions
ls -la ~/.zsh_history

# Fix permissions
chmod 600 ~/.zsh_history

# Check history variables
echo $HISTFILE
echo $HISTSIZE
```

### Slow Shell Startup
```bash
# Profile startup time
zsh -xv 2>&1 | ts -i "%.s"

# Common causes:
# - Too many plugins
# - Slow NFS home directory
# - Large history file

# Optimize: Lazy-load plugins
```

---

## Tips & Best Practices

1. **Use Aliases for Frequent Commands**
   ```bash
   # Add to ~/.zsh/aliases.zsh
   alias dev='cd ~/Documents/Lavoro'
   alias logs='tail -f /var/log/syslog'
   ```

2. **Functions for Complex Tasks**
   ```bash
   # Better than alias when you need arguments
   backup() {
       cp "$1" "$1.backup.$(date +%Y%m%d)"
   }
   ```

3. **Use History Effectively**
   - Press `Ctrl+r` and type to search
   - Use `!$` for last argument
   - Use `!!` to repeat last command

4. **Tab Completion**
   - Always press Tab to complete
   - Double-tap Tab to see options
   - Use menu selection for navigation

5. **Work Function for Projects**
   - Use `work-*` aliases for quick access
   - Keep venvs in project directories
   - Use `recreate-venv` when dependencies break

6. **Directory Navigation**
   - Use `cd -` to toggle between directories
   - Use `z` or `autojump` for frequent paths
   - Use `pushd`/`popd` for complex navigation

---

## Quick Reference Card

```
LAVORO PROJECTS:
work <project>          → Navigate and activate venv
work-hdb                → Quick: hyperdnabert
work-ana                → Quick: anamnesis
work-prism              → Quick: prism_sr_hdnabert
work-cgkt               → Quick: cgkt
recreate-venv           → Rebuild broken venv

GIT ALIASES:
gaa                     → git add --all
gcmsg "msg"             → git commit -m "msg"
gco branch              → git checkout branch
gd                      → git diff
gp                      → git push
gl                      → git pull
gst                     → git status
glog                    → git log --graph

NAVIGATION:
..                      → cd ..
...                     → cd ../..
cd -                    → Previous directory
z project               → Jump to project

HISTORY:
Ctrl+r                  → Search history
!!                      → Repeat last command
!$                      → Last argument
history | grep cmd      → Search history for cmd

COMPLETION:
<TAB>                   → Complete
<TAB><TAB>              → Show options
Ctrl+x Ctrl+h           → Complete from history

EDITING:
Ctrl+a                  → Beginning of line
Ctrl+e                  → End of line
Ctrl+w                  → Delete word backward
Ctrl+k                  → Delete to end of line
Ctrl+u                  → Delete to beginning of line

JOBS:
Ctrl+z                  → Suspend job
fg                      → Foreground job
bg                      → Background job
jobs                    → List jobs

SYSTEM:
source ~/.zshrc         → Reload config
exec zsh                → Restart shell
```

---

**Note**: All custom functions and aliases are defined in `~/.zsh/` directory and automatically loaded by `~/.zshrc`.
