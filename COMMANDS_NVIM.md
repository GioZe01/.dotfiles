# Neovim - Complete Command Reference (ThePrimeagen-style)

## Core Concepts
- **Modal Editor**: Different modes for different tasks (Normal, Insert, Visual, Command)
- **Leader Key**: Space (⎵) - prefix for custom commands
- **Vim Motions**: Efficient text navigation and editing
- **Plugins**: lazy.nvim manages all plugins
- **LSP**: Language Server Protocol for code intelligence

---

## Modes

### Mode Switching
| Key | Mode | Description |
|-----|------|-------------|
| `ESC` or `Ctrl+[` | Normal | Navigation and commands |
| `i` | Insert | Before cursor |
| `a` | Insert | After cursor |
| `I` | Insert | Beginning of line |
| `A` | Insert | End of line |
| `o` | Insert | New line below |
| `O` | Insert | New line above |
| `v` | Visual | Character selection |
| `V` | Visual Line | Line selection |
| `Ctrl+v` | Visual Block | Block selection |
| `:` | Command | Ex commands |
| `R` | Replace | Replace mode |

---

## Navigation (Normal Mode)

### Basic Movement
| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Forward one word (beginning) |
| `e` | Forward to word end |
| `b` | Backward one word |
| `W` | Forward one WORD (space-separated) |
| `E` | Forward to WORD end |
| `B` | Backward one WORD |

### Line Movement
| Key | Action |
|-----|--------|
| `0` | Beginning of line |
| `^` | First non-blank character |
| `$` | End of line |
| `g_` | Last non-blank character |
| `gg` | First line of file |
| `G` | Last line of file |
| `123G` or `:123` | Go to line 123 |
| `%` | Jump to matching bracket/paren |

### Screen Movement
| Key | Action |
|-----|--------|
| `Ctrl+d` | Scroll down half page (centered) |
| `Ctrl+u` | Scroll up half page (centered) |
| `Ctrl+f` | Scroll down full page |
| `Ctrl+b` | Scroll up full page |
| `zz` | Center cursor on screen |
| `zt` | Cursor to top of screen |
| `zb` | Cursor to bottom of screen |
| `H` | Move to top of screen |
| `M` | Move to middle of screen |
| `L` | Move to bottom of screen |

### Search Movement
| Key | Action |
|-----|--------|
| `f{char}` | Find next {char} on line |
| `F{char}` | Find previous {char} on line |
| `t{char}` | Till next {char} (before it) |
| `T{char}` | Till previous {char} (after it) |
| `;` | Repeat last f/F/t/T |
| `,` | Repeat last f/F/t/T backward |
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward for pattern |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |

---

## Editing (Normal Mode)

### Deletion
| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dw` | Delete word |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `d$` | Delete to end of line |
| `d0` | Delete to beginning of line |
| `dj` | Delete current and next line |
| `dk` | Delete current and previous line |
| `diw` | Delete inner word |
| `daw` | Delete a word (with whitespace) |
| `di"` | Delete inside quotes |
| `da"` | Delete around quotes (with quotes) |
| `di(` or `dib` | Delete inside parentheses |
| `da(` or `dab` | Delete around parentheses |
| `di{` or `diB` | Delete inside braces |
| `da{` or `daB` | Delete around braces |

### Change (Delete and Insert)
| Key | Action |
|-----|--------|
| `cw` | Change word |
| `cc` | Change line |
| `C` | Change to end of line |
| `c$` | Change to end of line |
| `ciw` | Change inner word |
| `caw` | Change a word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ci{` | Change inside braces |

### Copy (Yank)
| Key | Action |
|-----|--------|
| `yy` | Yank (copy) line |
| `Y` | Yank line |
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `yiw` | Yank inner word |
| `yi"` | Yank inside quotes |
| `yi(` | Yank inside parentheses |

### Paste
| Key | Action |
|-----|--------|
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `]p` | Paste and adjust indent |

### Undo/Redo
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `U` | Undo all changes on line |

### Repeat and Macros
| Key | Action |
|-----|--------|
| `.` | Repeat last change |
| `q{letter}` | Start recording macro to {letter} |
| `q` | Stop recording macro |
| `@{letter}` | Play macro {letter} |
| `@@` | Replay last macro |

---

## Visual Mode

### Selection
| Key | Action |
|-----|--------|
| `v` | Enter visual mode (character) |
| `V` | Enter visual line mode |
| `Ctrl+v` | Enter visual block mode |
| `o` | Move to other end of selection |
| `gv` | Reselect last selection |
| `aw` | Select a word |
| `iw` | Select inner word |
| `a"` | Select around quotes |
| `i"` | Select inside quotes |
| `a(` or `ab` | Select around parentheses |
| `i(` or `ib` | Select inside parentheses |
| `a{` or `aB` | Select around braces |
| `i{` or `iB` | Select inside braces |

### Visual Mode Operations
| Key | Action |
|-----|--------|
| `d` | Delete selection |
| `c` | Change selection |
| `y` | Yank (copy) selection |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `~` | Toggle case |
| `u` | Lowercase |
| `U` | Uppercase |

---

## Custom Keybindings (Leader = Space)

### File Navigation (Telescope)
| Keybinding | Action |
|------------|--------|
| `<Leader>pf` | Find files in project |
| `<Leader>ps` | Search (grep) in project files |
| `<Leader>pv` | Open file explorer (netrw) |
| `Ctrl+p` | Find git files |
| `<Leader>pg` | Live grep in project |
| `<Leader>pb` | Browse buffers |
| `<Leader>ph` | Search help tags |
| `<Leader>pr` | Search recent files |

### File Explorer (Netrw)
| Key | Action |
|-----|--------|
| `<Leader>pv` | Open file explorer |
| `Return` | Open file/directory |
| `-` | Go up directory |
| `d` | Create directory |
| `%` | Create new file |
| `D` | Delete file/directory |
| `R` | Rename file |

### Git (Fugitive)
| Keybinding | Action |
|------------|--------|
| `<Leader>gs` | Git status |
| `<Leader>gc` | Git commit |
| `<Leader>gp` | Git push |
| `<Leader>gl` | Git log |
| `<Leader>gd` | Git diff |
| `<Leader>gb` | Git blame |

### LSP (Language Server)
| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Show hover documentation |
| `<Leader>rn` | Rename symbol |
| `<Leader>ca` | Code action |
| `<Leader>f` | Format document |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<Leader>e` | Show diagnostic float |
| `<Leader>q` | Show diagnostic list |

### Completion (nvim-cmp)
| Key | Action |
|-----|--------|
| `Ctrl+Space` | Trigger completion |
| `Ctrl+n` | Next completion item |
| `Ctrl+p` | Previous completion item |
| `Ctrl+y` | Confirm completion |
| `Ctrl+e` | Close completion menu |
| `Ctrl+d` | Scroll docs down |
| `Ctrl+u` | Scroll docs up |

### Buffers
| Keybinding | Action |
|------------|--------|
| `<Leader>bd` | Delete buffer |
| `<Leader>bn` | Next buffer |
| `<Leader>bp` | Previous buffer |
| `<Leader>bb` | Browse buffers (Telescope) |

### Windows/Splits
| Keybinding | Action |
|------------|--------|
| `<Leader>sv` | Split vertically |
| `<Leader>sh` | Split horizontally |
| `<Leader>se` | Make splits equal size |
| `<Leader>sx` | Close current split |
| `Ctrl+h` | Navigate to left window |
| `Ctrl+j` | Navigate to down window |
| `Ctrl+k` | Navigate to up window |
| `Ctrl+l` | Navigate to right window |

### Clipboard (System)
| Keybinding | Action |
|------------|--------|
| `<Leader>y` | Yank to system clipboard |
| `<Leader>Y` | Yank line to system clipboard |
| `<Leader>p` | Paste from system clipboard |

### Undotree
| Keybinding | Action |
|------------|--------|
| `<Leader>u` | Toggle undotree |

### Zen Mode
| Keybinding | Action |
|------------|--------|
| `<Leader>zz` | Toggle zen mode |
| `<Leader>zZ` | Toggle zen mode (full) |

### Search and Replace
| Keybinding | Action |
|------------|--------|
| `<Leader>s` | Search and replace word under cursor |

### Quickfix List
| Keybinding | Action |
|------------|--------|
| `<Leader>co` | Open quickfix list |
| `<Leader>cc` | Close quickfix list |
| `]q` | Next quickfix item |
| `[q` | Previous quickfix item |

---

## Command Mode

### File Operations
```vim
:w                      " Save file
:w filename             " Save as filename
:wq or :x               " Save and quit
:q                      " Quit
:q!                     " Quit without saving
:qa                     " Quit all windows
:wa                     " Write all buffers
:wqa                    " Write all and quit

:e filename             " Edit file
:e!                     " Reload file (discard changes)
:saveas filename        " Save as new filename

:r filename             " Read file and insert below cursor
:r !command             " Read command output
```

### Buffer Management
```vim
:ls or :buffers         " List all buffers
:b {number}             " Switch to buffer number
:b {name}               " Switch to buffer by name
:bn                     " Next buffer
:bp                     " Previous buffer
:bd                     " Delete buffer
:bd {number}            " Delete specific buffer
:%bd                    " Delete all buffers
:%bd|e#|bd#             " Delete all but current
```

### Window Management
```vim
:sp or :split           " Horizontal split
:vsp or :vsplit         " Vertical split
:sp filename            " Open file in horizontal split
:vsp filename           " Open file in vertical split

:on or :only            " Close all windows except current

Ctrl+w s                " Horizontal split
Ctrl+w v                " Vertical split
Ctrl+w q                " Close current window
Ctrl+w o                " Close all windows except current

Ctrl+w h/j/k/l          " Navigate windows
Ctrl+w H/J/K/L          " Move window to direction
Ctrl+w =                " Equal window sizes
Ctrl+w _                " Maximize height
Ctrl+w |                " Maximize width

Ctrl+w +/-              " Resize height
Ctrl+w >/<              " Resize width
:resize 20              " Set height to 20
:vertical resize 80     " Set width to 80
```

### Tab Management
```vim
:tabnew                 " New tab
:tabnew filename        " Open file in new tab
:tabc                   " Close current tab
:tabo                   " Close all other tabs

:tabn or gt             " Next tab
:tabp or gT             " Previous tab
:tabfirst               " First tab
:tablast                " Last tab
:tabm {position}        " Move tab to position
```

### Search and Replace
```vim
/pattern                " Search forward
?pattern                " Search backward
:noh                    " Clear search highlighting

:%s/old/new/g           " Replace all in file
:%s/old/new/gc          " Replace all with confirmation
:s/old/new/g            " Replace all in line
:'<,'>s/old/new/g       " Replace in visual selection

:g/pattern/d            " Delete all lines matching pattern
:g!/pattern/d           " Delete all lines NOT matching
:v/pattern/d            " Same as :g!
```

### External Commands
```vim
:!command               " Run shell command
:r !command             " Insert command output
:w !command             " Pipe buffer to command
:'<,'>!command          " Filter selection through command

:term                   " Open terminal
:term python            " Open terminal with command
```

---

## Plugins

### Lazy.nvim (Plugin Manager)
| Keybinding | Action |
|------------|--------|
| `<Leader>l` | Open Lazy UI |

**Lazy Commands**:
```vim
:Lazy                   " Open Lazy UI
:Lazy update            " Update all plugins
:Lazy sync              " Sync plugins (install/update/clean)
:Lazy clean             " Remove unused plugins
:Lazy check             " Check for updates
:Lazy log               " Show recent updates
:Lazy profile           " Show plugin load times
```

### Telescope (Fuzzy Finder)
| Keybinding | Action |
|------------|--------|
| `<Leader>pf` | Find files |
| `<Leader>ps` | Grep in files |
| `<Leader>pg` | Live grep |
| `<Leader>pb` | Browse buffers |
| `<Leader>ph` | Help tags |
| `Ctrl+p` | Git files |

**In Telescope**:
```
Ctrl+n              " Next item
Ctrl+p              " Previous item
Ctrl+c              " Close Telescope
<CR>                " Select item
Ctrl+x              " Open in horizontal split
Ctrl+v              " Open in vertical split
Ctrl+t              " Open in new tab
Ctrl+u              " Scroll preview up
Ctrl+d              " Scroll preview down
```

### Treesitter (Syntax Highlighting)
```vim
:TSUpdate               " Update all parsers
:TSUpdate {language}    " Update specific parser
:TSInstall {language}   " Install parser
:TSUninstall {language} " Uninstall parser
:TSInstallInfo          " Show parser info
:TSModuleInfo           " Show enabled modules
```

**Incremental Selection**:
```
gnn                     " Init selection
grn                     " Increment selection
grc                     " Increment scope
grm                     " Decrement selection
```

### LSP (Mason)
```vim
:Mason                  " Open Mason UI
:MasonInstall pyright   " Install Python LSP
:MasonInstall lua_ls    " Install Lua LSP
:MasonUninstall pyright " Uninstall LSP
:LspInfo                " Show LSP info
:LspStart               " Start LSP
:LspStop                " Stop LSP
:LspRestart             " Restart LSP
```

**Common LSP Servers**:
- **Python**: pyright, pylsp
- **JavaScript/TypeScript**: tsserver
- **Lua**: lua_ls
- **Bash**: bashls
- **JSON**: jsonls
- **YAML**: yamlls

### Fugitive (Git)
```vim
:G or :Git              " Git status
:G add .                " Git add
:G commit               " Git commit
:G push                 " Git push
:G pull                 " Git pull
:G diff                 " Git diff
:G blame                " Git blame
:G log                  " Git log

:Gwrite                 " Git add current file
:Gread                  " Git checkout current file
:Gremove                " Git rm current file
:Gmove                  " Git mv current file
```

**In Git Status (`:G`)**:
```
s                       " Stage file under cursor
u                       " Unstage file
=                       " Toggle diff
cc                      " Create commit
ca                      " Amend commit
-                       " Stage/unstage
X                       " Discard changes
```

### Undotree
| Keybinding | Action |
|------------|--------|
| `<Leader>u` | Toggle undotree |

**In Undotree**:
```
j/k                     " Navigate tree
<CR>                    " Restore to state
q                       " Close undotree
```

### Surround
```vim
" Add surrounding
ysiw"                   " Surround inner word with "
yss"                    " Surround entire line with "
ysiw)                   " Surround with ( )
ysiw}                   " Surround with { }

" Change surrounding
cs"'                    " Change " to '
cs({                    " Change ( to {
cs)]                    " Change ) to ]

" Delete surrounding
ds"                     " Delete surrounding "
ds)                     " Delete surrounding ( )
ds}                     " Delete surrounding { }

" Visual mode
S"                      " Surround selection with "
```

### Comment
```vim
gcc                     " Toggle comment line
gc{motion}              " Comment motion (e.g., gcap for paragraph)
gc                      " Comment visual selection (visual mode)
gbc                     " Toggle block comment
```

### Autopairs
- Automatically closes brackets, quotes, etc.
- `(` → `()`
- `"` → `""`
- `{<CR>` → Creates balanced braces with newline

---

## Advanced Features

### Marks
```vim
m{letter}               " Set mark
'{letter}               " Jump to mark (line)
`{letter}               " Jump to mark (exact position)
:marks                  " List all marks
:delmarks {marks}       " Delete marks

" Special marks
''                      " Jump to position before last jump
`.                      " Jump to last change
`^                      " Jump to last insert
```

### Registers
```vim
"{register}             " Use specific register

:reg                    " Show all registers
:reg a b c              " Show specific registers

" Special registers
"a-"z                   " Named registers
"0                      " Last yank
"1-"9                   " Delete history
"+                      " System clipboard
"*                      " Selection clipboard
"%                      " Current filename
":                      " Last command
"/                      " Last search

" Examples
"ayy                    " Yank line to register a
"ap                     " Paste from register a
"+y                     " Yank to system clipboard
"+p                     " Paste from system clipboard
```

### Folds
```vim
zf{motion}              " Create fold
zf}                     " Fold paragraph
zfa{                    " Fold brace block

zo                      " Open fold
zc                      " Close fold
zO                      " Open all folds recursively
zC                      " Close all folds recursively
za                      " Toggle fold
zR                      " Open all folds in file
zM                      " Close all folds in file

zj                      " Move to next fold
zk                      " Move to previous fold
```

### Sessions
```vim
:mksession session.vim  " Save session
:source session.vim     " Load session

" Auto-save session
:mksession! ~/.vim/sessions/project.vim
```

### Spell Checking
```vim
:set spell              " Enable spell check
:set nospell            " Disable spell check
:set spelllang=en_us    " Set language

]s                      " Next misspelled word
[s                      " Previous misspelled word
z=                      " Suggest corrections
zg                      " Add word to dictionary
zw                      " Mark as misspelled
```

---

## Configuration

### Config File Structure
```
~/.config/nvim/
├── init.lua                    # Entry point
└── lua/config/
    ├── lazy.lua                # Plugin manager
    ├── options.lua             # Vim options
    ├── keymaps.lua             # Key mappings
    ├── autocmds.lua            # Autocommands
    └── plugins/
        ├── telescope.lua       # Fuzzy finder
        ├── treesitter.lua      # Syntax highlighting
        ├── lsp.lua             # LSP config
        ├── completion.lua      # Autocompletion
        ├── git.lua             # Git plugins
        ├── ui.lua              # UI enhancements
        ├── colorscheme.lua     # Color theme
        └── editor.lua          # Editor plugins
```

### Edit Configuration
```vim
:e ~/.config/nvim/init.lua
:e ~/.config/nvim/lua/config/keymaps.lua
:e ~/.config/nvim/lua/config/options.lua
```

### Reload Configuration
```vim
:source ~/.config/nvim/init.lua
:so %                   " Source current file
:lua vim.reload()       " Reload Lua modules
```

### Check Health
```vim
:checkhealth            " Check all health
:checkhealth nvim       " Check Neovim health
:checkhealth lsp        " Check LSP health
:checkhealth treesitter " Check Treesitter health
```

---

## Workflow Examples

### Python Development
```vim
" Open project
cd ~/Documents/Lavoro/hyperdnabert
nvim src/model.py

" Find files
<Leader>pf
" Type: train.py

" Search for function
<Leader>ps
" Type: def train

" Go to definition
gd

" Show documentation
K

" Find references
gr

" Rename variable
<Leader>rn

" Format file
<Leader>f

" Run tests
:term pytest tests/

" Git status
<Leader>gs

" Stage changes and commit
s (in fugitive)
cc (create commit)
```

### Multi-File Editing
```vim
" Open multiple files
:e file1.py
:sp file2.py
:vsp file3.py

" Or with Telescope
<Leader>pf
" Select multiple with Tab, open with Ctrl+q

" Navigate between windows
Ctrl+h/j/k/l

" Navigate between buffers
<Leader>bn
<Leader>bp

" Browse all buffers
<Leader>pb
```

### Search and Replace Workflow
```vim
" Find all occurrences
<Leader>ps
" Type: old_name

" Or search in current file
/old_name

" Replace in current file
:%s/old_name/new_name/gc

" Or use LSP rename
<Leader>rn
" Type: new_name
```

---

## Troubleshooting

### LSP Not Working
```vim
:LspInfo                " Check LSP status
:Mason                  " Install language server
:checkhealth lsp        " Check LSP health

" Restart LSP
:LspRestart

" Check log
:lua vim.cmd('e '..vim.lsp.get_log_path())
```

### Treesitter Errors
```vim
:checkhealth treesitter " Check status
:TSUpdate               " Update parsers
:TSInstall python       " Install specific parser

" Clear and reinstall
:TSUninstall python
:TSInstall python
```

### Plugin Not Loading
```vim
:Lazy                   " Check plugin status
:Lazy sync              " Sync plugins
:Lazy profile           " Check load times

" Clear cache
:lua vim.fn.delete(vim.fn.stdpath("data") .. "/lazy", "rf")
:Lazy sync
```

### Performance Issues
```vim
:Lazy profile           " Show plugin load times

" Check startup time
nvim --startuptime startup.log
:e startup.log

" Disable plugins temporarily
:Lazy disable <plugin-name>
```

---

## Tips & Best Practices

1. **Use Relative Line Numbers**: Jump quickly with `{count}j/k`
   ```vim
   :set relativenumber
   15j         " Jump down 15 lines
   ```

2. **Master Text Objects**: `ci"` `da(` `diw`
   - `i` = inner (without delimiters)
   - `a` = around (with delimiters)

3. **Use Dot Command**: Repeat last change
   ```vim
   ciw new_word <ESC>      " Change word
   w                       " Move to next
   .                       " Repeat change
   ```

4. **Registers for Clipboard**: System clipboard access
   ```vim
   "+yy        " Copy line to system clipboard
   "+p         " Paste from system clipboard
   ```

5. **Telescope for Everything**: Files, grep, buffers
   - `<Leader>pf` for files
   - `<Leader>ps` for search
   - `<Leader>pb` for buffers

6. **LSP for Code Intelligence**:
   - `gd` to go to definition
   - `K` for documentation
   - `<Leader>rn` to rename

7. **Undotree for Time Travel**:
   - `<Leader>u` to open
   - Navigate with `j/k`
   - `<CR>` to restore

8. **Visual Block for Column Editing**:
   ```vim
   Ctrl+v          " Visual block mode
   jjj             " Select 4 lines
   I// <ESC>       " Insert // at beginning
   ```

---

## Quick Reference Card

```
MODES:
i/a/o/O             → Insert mode
v/V/Ctrl+v          → Visual mode
:                   → Command mode
ESC                 → Normal mode

NAVIGATION:
h/j/k/l             → Left/Down/Up/Right
w/b                 → Word forward/backward
0/$                 → Line start/end
gg/G                → File start/end
Ctrl+d/u            → Page down/up (centered)

EDITING:
dd/yy/p             → Delete/Yank/Paste line
ciw/diw             → Change/Delete word
ci"/di"             → Change/Delete in quotes
u/Ctrl+r            → Undo/Redo
.                   → Repeat last change

LEADER (Space):
<Leader>pf          → Find files
<Leader>ps          → Search in files
<Leader>pv          → File explorer
<Leader>gs          → Git status
<Leader>u           → Undotree
<Leader>y           → Yank to clipboard

LSP:
gd                  → Go to definition
K                   → Hover docs
gr                  → Find references
<Leader>rn          → Rename
<Leader>ca          → Code action
<Leader>f           → Format
[d/]d               → Prev/Next diagnostic

WINDOWS:
Ctrl+h/j/k/l        → Navigate windows
<Leader>sv/sh       → Split vert/horiz
<Leader>sx          → Close split

BUFFERS:
<Leader>bn/bp       → Next/Prev buffer
<Leader>bd          → Delete buffer
<Leader>pb          → Browse buffers
```

---

**Note**: This configuration uses DejaVu Sans Mono font for clear visibility and rose-pine color scheme for high contrast retro aesthetics.
