#!/bin/bash
# Neovim Setup Diagnostic Script
# Checks if everything is configured correctly

set -e

echo "======================================"
echo "Neovim Setup Diagnostic"
echo "======================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check 1: Neovim installed
echo "1. Checking Neovim installation..."
if command -v nvim &> /dev/null; then
    VERSION=$(nvim --version | head -1)
    success "Neovim installed: $VERSION"
else
    error "Neovim not installed"
    echo "   Install with: sudo apt install neovim"
    exit 1
fi
echo ""

# Check 2: Config directory
echo "2. Checking configuration..."
if [ -L "$HOME/.config/nvim" ]; then
    TARGET=$(readlink -f "$HOME/.config/nvim")
    success "Config symlinked to: $TARGET"
elif [ -d "$HOME/.config/nvim" ]; then
    success "Config directory exists: $HOME/.config/nvim"
else
    error "Config directory not found"
    echo "   Run: cd ~/.dotfiles && stow nvim"
    exit 1
fi
echo ""

# Check 3: Required files
echo "3. Checking required files..."
FILES=(
    "$HOME/.config/nvim/init.lua"
    "$HOME/.config/nvim/lua/config/lazy.lua"
    "$HOME/.config/nvim/lua/config/plugins/telescope.lua"
    "$HOME/.config/nvim/lua/config/plugins/harpoon.lua"
    "$HOME/.config/nvim/lua/config/plugins/file-explorer.lua"
    "$HOME/.config/nvim/lua/config/plugins/lsp.lua"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        success "$(basename $file) exists"
    else
        error "Missing: $file"
    fi
done
echo ""

# Check 4: Plugin directory
echo "4. Checking plugins..."
if [ -d "$HOME/.local/share/nvim/lazy" ]; then
    PLUGIN_COUNT=$(ls -1 "$HOME/.local/share/nvim/lazy" | wc -l)
    success "Lazy.nvim plugin directory exists ($PLUGIN_COUNT plugins)"

    # Check specific plugins
    REQUIRED_PLUGINS=("telescope.nvim" "harpoon" "oil.nvim" "plenary.nvim" "mason.nvim")
    for plugin in "${REQUIRED_PLUGINS[@]}"; do
        if [ -d "$HOME/.local/share/nvim/lazy/$plugin" ]; then
            success "  $plugin installed"
        else
            warning "  $plugin not installed"
            echo "     Will be installed on first Neovim launch"
        fi
    done
else
    warning "Plugin directory not found (will be created on first launch)"
    echo "   Plugins will install automatically when you open Neovim"
fi
echo ""

# Check 5: LSP servers
echo "5. Checking LSP servers (Mason)..."
if [ -d "$HOME/.local/share/nvim/mason/packages" ]; then
    LSP_COUNT=$(ls -1 "$HOME/.local/share/nvim/mason/packages" 2>/dev/null | wc -l)
    if [ $LSP_COUNT -gt 0 ]; then
        success "Mason directory exists ($LSP_COUNT LSP servers)"

        # Check specific servers
        SERVERS=("pyright" "ruff-lsp" "lua-language-server" "bash-language-server")
        for server in "${SERVERS[@]}"; do
            if [ -d "$HOME/.local/share/nvim/mason/packages/$server" ]; then
                success "  $server installed"
            else
                warning "  $server not installed"
            fi
        done
    else
        warning "No LSP servers installed yet"
        echo "   Install with: nvim then :Mason"
    fi
else
    warning "Mason not initialized yet"
    echo "   Will be set up on first Neovim launch"
fi
echo ""

# Check 6: Dependencies
echo "6. Checking system dependencies..."
DEPS=("git" "rg" "fd" "make" "gcc")
for dep in "${DEPS[@]}"; do
    if command -v $dep &> /dev/null; then
        success "$dep installed"
    else
        error "$dep not installed"
        case $dep in
            rg)
                echo "   Install with: sudo apt install ripgrep"
                ;;
            fd)
                echo "   Install with: sudo apt install fd-find"
                ;;
            *)
                echo "   Install with: sudo apt install $dep"
                ;;
        esac
    fi
done
echo ""

# Check 7: Project detection
echo "7. Checking project markers in current directory..."
PWD_DIR=$(pwd)
echo "   Current directory: $PWD_DIR"

if [ -d ".git" ]; then
    success "Git repository detected (.git folder)"
elif [ -f "pyproject.toml" ]; then
    success "Python project detected (pyproject.toml)"
elif [ -f "package.json" ]; then
    success "Node.js project detected (package.json)"
elif [ -f "Cargo.toml" ]; then
    success "Rust project detected (Cargo.toml)"
elif [ -f ".projectroot" ]; then
    success "Project marker detected (.projectroot)"
else
    warning "No project marker found in current directory"
    echo "   Neovim will use current directory as root"
    echo "   Consider: git init  OR  touch .projectroot"
fi
echo ""

# Check 8: Session directory
echo "8. Checking session directory..."
if [ -d "$HOME/.vim/sessions" ]; then
    SESSION_COUNT=$(ls -1 "$HOME/.vim/sessions" 2>/dev/null | wc -l)
    success "Session directory exists ($SESSION_COUNT sessions saved)"
else
    warning "Session directory doesn't exist yet"
    echo "   Will be created when you use :Obsession"
fi
echo ""

# Check 9: Telescope native extension
echo "9. Checking Telescope native extension..."
if [ -f "$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so" ]; then
    success "Telescope FZF native extension compiled"
else
    warning "Telescope FZF native extension not compiled"
    echo "   Build with:"
    echo "   cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim"
    echo "   make"
fi
echo ""

# Summary
echo "======================================"
echo "Summary"
echo "======================================"
echo ""
echo "If you see warnings above:"
echo "1. Open Neovim to install plugins: nvim"
echo "2. Install LSP servers: :Mason"
echo "3. Build native extensions if needed"
echo ""
echo "To test navigation, open Neovim and try:"
echo "  <Space>pf  - Find files (Telescope)"
echo "  <Space>pv  - File explorer (Oil)"
echo "  <Space>a   - Mark file (Harpoon)"
echo "  <Space>h   - Show marks (Harpoon)"
echo ""
echo "For detailed help, read:"
echo "  ~/.dotfiles/NEOVIM_SETUP_GUIDE.md"
echo "  ~/.dotfiles/COMMANDS_NEOVIM.md"
echo ""
echo "======================================"
