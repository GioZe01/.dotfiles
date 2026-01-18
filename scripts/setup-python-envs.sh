#!/bin/bash

# Recreate Python virtual environments for all Lavoro projects
# Removes broken venvs (with Windows paths) and creates new ones

set -e

LAVORO_DIR="$HOME/Documents/Lavoro"

# Lavoro projects that need venvs
PROJECTS=(
    "hyperdnabert"
    "anamnesis"
    "prism_sr_hdnabert"
    "cgkt"
)

echo "Setting up Python virtual environments for Lavoro projects"
echo "Lavoro directory: $LAVORO_DIR"
echo ""

if [ ! -d "$LAVORO_DIR" ]; then
    echo "Error: Lavoro directory not found at $LAVORO_DIR"
    exit 1
fi

for project in "${PROJECTS[@]}"; do
    project_dir="$LAVORO_DIR/$project"

    if [ ! -d "$project_dir" ]; then
        echo "Warning: Project directory not found: $project_dir"
        echo "Skipping..."
        continue
    fi

    echo "-------------------------------------------"
    echo "Processing: $project"
    echo "-------------------------------------------"

    cd "$project_dir"

    # Remove existing venv if it exists
    if [ -d "venv" ]; then
        echo "Removing old venv..."
        rm -rf venv
    fi

    # Create new venv
    echo "Creating new virtual environment..."
    python3 -m venv venv

    # Activate venv
    source venv/bin/activate

    # Upgrade pip
    echo "Upgrading pip..."
    pip install --upgrade pip

    # Install project in editable mode
    if [ -f "pyproject.toml" ]; then
        echo "Installing project (pip install -e .)..."
        pip install -e .
    elif [ -f "requirements.txt" ]; then
        echo "Installing from requirements.txt..."
        pip install -r requirements.txt
    else
        echo "Warning: No pyproject.toml or requirements.txt found"
    fi

    # Deactivate venv
    deactivate

    echo "✓ $project venv setup complete"
    echo ""
done

echo "-------------------------------------------"
echo "All virtual environments created!"
echo ""
echo "Test with:"
echo "  source ~/.zshrc"
echo "  work hyperdnabert"
