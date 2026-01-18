# Zsh functions
# Python environment management for Lavoro projects

# Navigate to Lavoro project and activate venv
work() {
    if [ -z "$1" ]; then
        echo "Usage: work <project-name>"
        echo "Available projects:"
        if [ -d "$LAVORO_DIR" ]; then
            ls -1 "$LAVORO_DIR"
        fi
        return 1
    fi

    local project_name="$1"
    local project_dir="$LAVORO_DIR/$project_name"

    if [ ! -d "$project_dir" ]; then
        echo "Error: Project not found: $project_dir"
        return 1
    fi

    cd "$project_dir"

    if [ -d "venv" ]; then
        source venv/bin/activate
        echo "Activated venv for $project_name"
        echo "Current directory: $(pwd)"
    else
        echo "Warning: No venv found in $project_dir"
        echo "Run 'recreate-venv' to create one"
    fi
}

# Quick aliases for Lavoro projects
work-hdb() {
    work hyperdnabert
}

work-ana() {
    work anamnesis
}

work-prism() {
    work prism_sr_hdnabert
}

work-cgkt() {
    work cgkt
}

# Recreate virtual environment for current project
recreate-venv() {
    if [ ! -f "pyproject.toml" ] && [ ! -f "requirements.txt" ]; then
        echo "Error: Not in a Python project directory"
        echo "No pyproject.toml or requirements.txt found"
        return 1
    fi

    echo "Recreating virtual environment..."

    # Deactivate if currently in a venv
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    fi

    # Remove old venv
    if [ -d "venv" ]; then
        echo "Removing old venv..."
        rm -rf venv
    fi

    # Create new venv
    echo "Creating new venv..."
    python3 -m venv venv

    # Activate
    source venv/bin/activate

    # Upgrade pip
    echo "Upgrading pip..."
    pip install --upgrade pip

    # Install project
    if [ -f "pyproject.toml" ]; then
        echo "Installing project (pip install -e .)..."
        pip install -e .
    elif [ -f "requirements.txt" ]; then
        echo "Installing from requirements.txt..."
        pip install -r requirements.txt
    fi

    echo "✓ Virtual environment recreated successfully"
}

# List all Lavoro projects
lavoro-ls() {
    if [ -d "$LAVORO_DIR" ]; then
        echo "Lavoro projects in $LAVORO_DIR:"
        ls -1 "$LAVORO_DIR"
    else
        echo "Lavoro directory not found: $LAVORO_DIR"
    fi
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}
