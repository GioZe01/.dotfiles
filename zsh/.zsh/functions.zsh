# Zsh functions
# Python environment management for Lavoro projects

# Config file for custom work projects
WORK_PROJECTS_CONFIG="${HOME}/.zsh/work_projects.conf"

# Initialize config file if it doesn't exist
if [ ! -f "$WORK_PROJECTS_CONFIG" ]; then
    mkdir -p "$(dirname "$WORK_PROJECTS_CONFIG")"
    cat > "$WORK_PROJECTS_CONFIG" << 'EOF'
# Work Projects Configuration
# Format: shortcut:project_name:full_path
# Multiple shortcuts can point to same project (one per line)
# Example: ana:anamnesis:/home/gio/Documents/Lavoro/Linfoma/ANAMNESIS

# Default Lavoro projects (auto-generated)
hdb:hyperdnabert:${LAVORO_DIR}/hyperdnabert
anamnesis:anamnesis:${LAVORO_DIR}/anamnesis
prism:prism_sr_hdnabert:${LAVORO_DIR}/prism_sr_hdnabert
cgkt:cgkt:${LAVORO_DIR}/cgkt
EOF
fi

# Update .gitignore to exclude a project path
_work_update_gitignore() {
    local project_path="$1"
    local gitignore="${HOME}/.dotfiles/.gitignore"

    if [ ! -f "$gitignore" ]; then
        echo "Warning: .gitignore not found at $gitignore"
        return 1
    fi

    # Get relative path from home or absolute path
    local exclude_pattern
    if [[ "$project_path" == "${HOME}"* ]]; then
        # Relative to home
        exclude_pattern="${project_path#$HOME/}"
    else
        # Absolute path
        exclude_pattern="$project_path"
    fi

    # Check if pattern already in gitignore
    if grep -Fq "$exclude_pattern" "$gitignore" 2>/dev/null; then
        return 0  # Already excluded
    fi

    # Add to gitignore under Lavoro section
    if grep -q "# Lavoro Work Directories" "$gitignore" 2>/dev/null; then
        # Add after the Lavoro comment
        sed -i "/# Lavoro Work Directories/a $exclude_pattern/" "$gitignore"
    else
        # Lavoro section doesn't exist, add it
        echo "" >> "$gitignore"
        echo "# Lavoro Work Directories - NEVER COMMIT THESE" >> "$gitignore"
        echo "$exclude_pattern/" >> "$gitignore"
    fi

    echo "✓ Added to .gitignore: $exclude_pattern"
}

# Lookup project path from config by shortcut or name
_work_lookup_project() {
    local query="$1"
    local config="$WORK_PROJECTS_CONFIG"

    if [ ! -f "$config" ]; then
        return 1
    fi

    # Expand environment variables in config and search
    while IFS=: read -r shortcut name path; do
        # Skip comments and empty lines
        [[ "$shortcut" =~ ^#.*$ ]] && continue
        [[ -z "$shortcut" ]] && continue

        # Expand environment variables
        path=$(eval echo "$path")

        # Match by shortcut or name
        if [[ "$shortcut" == "$query" ]] || [[ "$name" == "$query" ]]; then
            echo "$path"
            return 0
        fi
    done < "$config"

    return 1
}

# Open Neovim with session for a project
_work_nvim_session() {
    local project_name="$1"
    local session_dir="$HOME/.vim/sessions"
    local session_file="$session_dir/${project_name}.vim"

    mkdir -p "$session_dir"

    if [ -f "$session_file" ]; then
        echo "📝 Restoring session: $project_name"
        nvim -S "$session_file"
    else
        echo "📝 Starting new session: $project_name"
        nvim "+Obsession $session_file"
    fi
}

# Navigate to Lavoro project and activate venv
work() {
    # Check for auto-nvim flag
    local auto_nvim=false
    if [ "$1" = "-e" ] || [ "$1" = "--edit" ]; then
        auto_nvim=true
        shift
    fi

    # Handle -a flag for adding new project
    if [ "$1" = "-a" ]; then
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: work -a <shortcut> <project-name> [additional-shortcuts...]"
            echo ""
            echo "Example from /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS:"
            echo "  work -a ana anamnesis"
            echo ""
            echo "This will:"
            echo "  1. Save current directory as 'anamnesis' project"
            echo "  2. Create shortcut 'ana' and 'anamnesis'"
            echo "  3. Add to .gitignore exclusions"
            echo "  4. Next time: 'work ana' or 'work anamnesis' will work"
            return 1
        fi

        local shortcut="$2"
        local project_name="$3"
        local current_dir="$(pwd)"
        shift 3
        local additional_shortcuts=("$@")

        # Validate we're in a directory
        if [ ! -d "$current_dir" ]; then
            echo "Error: Not in a valid directory"
            return 1
        fi

        echo "Adding project from current location..."
        echo "  Directory: $current_dir"
        echo "  Project name: $project_name"
        echo "  Primary shortcut: $shortcut"

        # Add primary shortcut
        echo "$shortcut:$project_name:$current_dir" >> "$WORK_PROJECTS_CONFIG"
        echo "✓ Added shortcut: $shortcut"

        # Add project name as shortcut too (if different from primary)
        if [ "$shortcut" != "$project_name" ]; then
            echo "$project_name:$project_name:$current_dir" >> "$WORK_PROJECTS_CONFIG"
            echo "✓ Added shortcut: $project_name"
        fi

        # Add additional shortcuts
        for alt_shortcut in "${additional_shortcuts[@]}"; do
            echo "$alt_shortcut:$project_name:$current_dir" >> "$WORK_PROJECTS_CONFIG"
            echo "✓ Added shortcut: $alt_shortcut"
        done

        # Update .gitignore
        _work_update_gitignore "$current_dir"

        echo ""
        echo "✅ Project added successfully!"
        echo ""
        echo "Usage:"
        echo "  work $shortcut"
        echo "  work $project_name"
        for alt in "${additional_shortcuts[@]}"; do
            echo "  work $alt"
        done

        return 0
    fi

    # Handle -l flag for listing projects
    if [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
        echo "Available work projects:"
        echo ""

        if [ -f "$WORK_PROJECTS_CONFIG" ]; then
            echo "Custom projects (from config):"
            local prev_name=""
            while IFS=: read -r shortcut name path; do
                [[ "$shortcut" =~ ^#.*$ ]] && continue
                [[ -z "$shortcut" ]] && continue

                # Expand env vars
                path=$(eval echo "$path")

                # Group by project name
                if [ "$name" != "$prev_name" ]; then
                    [ -n "$prev_name" ] && echo ""
                    echo "  $name ($path)"
                    echo "    Shortcuts: $shortcut"
                    prev_name="$name"
                else
                    echo -n ", $shortcut"
                fi
            done < "$WORK_PROJECTS_CONFIG"
            echo ""
        fi

        echo ""
        echo "Legacy projects (from \$LAVORO_DIR):"
        if [ -d "$LAVORO_DIR" ]; then
            ls -1 "$LAVORO_DIR" | sed 's/^/  /'
        fi

        return 0
    fi

    # Handle -h flag for help
    if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
        echo "Usage: work [options] <project>"
        echo ""
        echo "Options:"
        echo "  -e, --edit            Open project with Neovim session"
        echo "  -a <shortcut> <name>  Add current directory as a project"
        echo "  -l, --list            List all available projects"
        echo "  -h, --help            Show this help"
        echo ""
        echo "Examples:"
        echo "  work ana              Navigate to anamnesis project and activate venv"
        echo "  work -e ana           Same as above, but also open Neovim with session"
        echo "  work -a lnf linfoma   Add current dir as 'linfoma' with shortcut 'lnf'"
        echo "  work -l               List all projects"
        echo ""
        echo "After adding a project, you can use:"
        echo "  work <shortcut>       Quick access via shortcut"
        echo "  work <name>           Full project name"
        echo "  worke <name>          Alias for work -e <name>"
        return 0
    fi

    local query="$1"

    # Try to lookup in config first
    local project_dir=$(_work_lookup_project "$query")

    # Fallback to legacy LAVORO_DIR method
    if [ -z "$project_dir" ]; then
        project_dir="$LAVORO_DIR/$query"
    fi

    # Check if directory exists
    if [ ! -d "$project_dir" ]; then
        echo "Error: Project not found: $query"
        echo ""
        echo "Available projects:"
        work -l
        return 1
    fi

    cd "$project_dir"

    # Try to activate venv
    if [ -d "venv" ]; then
        source venv/bin/activate
        echo "✓ Activated venv for $query"
        echo "📂 Current directory: $(pwd)"
    else
        echo "⚠️  No venv found in $project_dir"
        echo "📂 Current directory: $(pwd)"
        echo ""
        echo "Run 'recreate-venv' to create one"
    fi

    # Auto-open nvim if -e flag was used
    if [ "$auto_nvim" = true ]; then
        _work_nvim_session "$query"
    fi
}

# Quick aliases for Lavoro projects (legacy compatibility)
work-hdb() {
    work hdb
}

work-ana() {
    work ana
}

work-prism() {
    work prism
}

work-cgkt() {
    work cgkt
}

# Recreate virtual environment for current project
recreate-venv() {
    if [ ! -f "pyproject.toml" ] && [ ! -f "requirements.txt" ] && [ ! -f "setup.py" ]; then
        echo "Error: Not in a Python project directory"
        echo "No pyproject.toml, requirements.txt, or setup.py found"
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
    elif [ -f "setup.py" ]; then
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
    work -l
}

# Remove a project from work config
work-remove() {
    if [ -z "$1" ]; then
        echo "Usage: work-remove <shortcut-or-name>"
        echo ""
        echo "This will remove the project mapping from config"
        echo "(but won't delete the actual directory)"
        return 1
    fi

    local query="$1"
    local config="$WORK_PROJECTS_CONFIG"
    local temp_file="${config}.tmp"

    if [ ! -f "$config" ]; then
        echo "No projects configured yet"
        return 1
    fi

    # Remove all entries matching shortcut or name
    local removed=0
    while IFS=: read -r shortcut name path; do
        [[ "$shortcut" =~ ^#.*$ ]] && echo "$shortcut:$name:$path" && continue
        [[ -z "$shortcut" ]] && continue

        if [[ "$shortcut" != "$query" ]] && [[ "$name" != "$query" ]]; then
            echo "$shortcut:$name:$path"
        else
            removed=1
        fi
    done < "$config" > "$temp_file"

    if [ $removed -eq 1 ]; then
        mv "$temp_file" "$config"
        echo "✓ Removed project: $query"
    else
        rm "$temp_file"
        echo "Project not found: $query"
        return 1
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
