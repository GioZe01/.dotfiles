#!/bin/bash

# Setup Data Science, ML, and Bioinformatics tools for Neovim

set -e

echo "========================================="
echo "Data Science & ML Setup for Neovim"
echo "========================================="
echo ""

# Check if running in a virtual environment
if [ -n "$VIRTUAL_ENV" ]; then
    echo "✓ Virtual environment detected: $VIRTUAL_ENV"
    INSTALL_CMD="pip install"
else
    echo "⚠ No virtual environment detected"
    echo "Installing globally (will use --user flag)"
    INSTALL_CMD="pip install --user"
fi

echo ""
echo "This script will install:"
echo "  1. Python packages for Jupyter integration"
echo "  2. bioSyntax for bioinformatics file highlighting"
echo "  3. Enable data science plugins in Neovim"
echo ""

read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Step 1: Installing Python packages..."
echo "---------------------------------------"

# Python packages for Jupyter/Molten
PYTHON_PACKAGES=(
    "pynvim"
    "jupyter"
    "jupyter_client"
    "jupytext"
    "ipykernel"
    "cairosvg"
    "pnglatex"
    "plotly"
    "kaleido"
    "pyperclip"
    "pillow"
    "matplotlib"
    "numpy"
    "pandas"
)

echo "Installing Python packages:"
for pkg in "${PYTHON_PACKAGES[@]}"; do
    echo "  - $pkg"
done

$INSTALL_CMD "${PYTHON_PACKAGES[@]}"

echo ""
echo "✓ Python packages installed"

echo ""
echo "Step 2: Installing bioSyntax (optional)"
echo "----------------------------------------"
read -p "Install bioSyntax for bioinformatics? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    BIOSYNTAX_DIR="$HOME/.local/share/biosyntax"

    if [ -d "$BIOSYNTAX_DIR" ]; then
        echo "bioSyntax already installed at $BIOSYNTAX_DIR"
        echo "Updating..."
        cd "$BIOSYNTAX_DIR"
        git pull
    else
        echo "Cloning bioSyntax..."
        git clone https://github.com/bioSyntax/bioSyntax.git "$BIOSYNTAX_DIR"
        cd "$BIOSYNTAX_DIR"
    fi

    echo "Running bioSyntax installer for Neovim..."
    bash bioSyntax_INSTALL.sh nvim

    echo "✓ bioSyntax installed"
else
    echo "Skipping bioSyntax installation"
fi

echo ""
echo "Step 3: Enabling Neovim plugins"
echo "--------------------------------"

DATASCIENCE_CONFIG="$HOME/.dotfiles/nvim/.config/nvim/lua/config/plugins/datascience.lua"

if [ ! -f "$DATASCIENCE_CONFIG" ]; then
    echo "Error: datascience.lua not found at $DATASCIENCE_CONFIG"
    exit 1
fi

echo "The following plugins are currently DISABLED:"
echo "  - molten-nvim (Jupyter integration)"
echo "  - image.nvim (image viewing)"
echo "  - markdown-preview.nvim (markdown preview)"
echo ""
echo "To enable them, edit: $DATASCIENCE_CONFIG"
echo "Change 'enabled = false' to 'enabled = true' for each plugin"
echo ""

read -p "Auto-enable all plugins now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Enabling plugins..."

    # Enable molten-nvim
    sed -i 's/enabled = false, -- Set to true after installing dependencies/enabled = true, -- Enabled by setup script/' "$DATASCIENCE_CONFIG"

    echo "✓ Plugins enabled"
    echo ""
    echo "⚠ Note: image.nvim still requires Kitty terminal or ueberzug++"
    echo "Install Kitty: sudo apt install kitty"
    echo "OR install ueberzug: pip install ueberzug"
else
    echo "Plugins remain disabled. Enable manually when ready."
fi

echo ""
echo "Step 4: Installing Jupyter kernel (optional)"
echo "---------------------------------------------"

read -p "Install Python kernel for Jupyter? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -n "$VIRTUAL_ENV" ]; then
        VENV_NAME=$(basename "$VIRTUAL_ENV")
        echo "Installing kernel for venv: $VENV_NAME"
        python -m ipykernel install --user --name "$VENV_NAME" --display-name "Python ($VENV_NAME)"
        echo "✓ Kernel installed: $VENV_NAME"
    else
        echo "Installing default Python kernel..."
        python -m ipykernel install --user --name python3 --display-name "Python 3"
        echo "✓ Default kernel installed"
    fi

    echo ""
    echo "List of installed kernels:"
    jupyter kernelspec list
else
    echo "Skipping kernel installation"
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Restart Neovim or run: nvim and :Lazy sync"
echo "  2. For Jupyter: Open a .py file and press <leader>mi"
echo "  3. For images: Install Kitty terminal (sudo apt install kitty)"
echo "  4. Read full guide: ~/.dotfiles/DATASCIENCE_NEOVIM.md"
echo ""
echo "Useful commands:"
echo "  work -e <project>     - Open project with session"
echo "  <leader>mi            - Initialize Jupyter kernel"
echo "  <leader>ml            - Run current line"
echo "  <leader>vs            - Select Python venv"
echo ""
