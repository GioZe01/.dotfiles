# Work Command - Dynamic Project Management

## Overview

The `work` command now supports **dynamically adding projects** from any location with custom shortcuts. Projects are automatically excluded from git commits.

---

## Quick Start

### Add a New Project from Current Location

```bash
# Navigate to your project
cd /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS

# Add it with shortcuts
work -a ana anamnesis

# Now you can use:
work ana        # or
work anamnesis
```

---

## Features

✅ **Add projects from anywhere** - No need to be in `$LAVORO_DIR`
✅ **Multiple shortcuts** - Create as many aliases as you want
✅ **Auto .gitignore** - Projects automatically excluded from git
✅ **Persistent config** - Saved in `~/.zsh/work_projects.conf`
✅ **Venv activation** - Automatically activates Python virtual environments
✅ **Backward compatible** - Old `work-hdb` shortcuts still work

---

## Usage

### Add a Project

From **any directory**, run:

```bash
work -a <shortcut> <project-name> [additional-shortcuts...]
```

**Example 1: Simple add**
```bash
cd /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS
work -a ana anamnesis
```

This creates:
- Shortcut: `ana`
- Shortcut: `anamnesis` (project name)
- Both point to: `/home/gio/Documents/Lavoro/Linfoma/ANAMNESIS`

**Example 2: Multiple shortcuts**
```bash
cd /home/gio/Projects/MyApp
work -a app myapp ma
```

This creates:
- Shortcut: `app`
- Shortcut: `myapp`
- Shortcut: `ma`
- All point to: `/home/gio/Projects/MyApp`

### Navigate to a Project

```bash
work <shortcut-or-name>
```

**Examples:**
```bash
work ana          # Navigate to ANAMNESIS
work anamnesis    # Same thing
work hdb          # Navigate to hyperdnabert (legacy)
work-ana          # Old-style alias (still works)
```

**What happens:**
1. Changes to project directory
2. Activates `venv` if it exists
3. Shows current location

### List All Projects

```bash
work -l
# or
work --list
```

**Output:**
```
Available work projects:

Custom projects (from config):
  anamnesis (/home/gio/Documents/Lavoro/Linfoma/ANAMNESIS)
    Shortcuts: ana, anamnesis

  hyperdnabert (/home/gio/Documents/Lavoro/hyperdnabert)
    Shortcuts: hdb, hyperdnabert

Legacy projects (from $LAVORO_DIR):
  prism_sr_hdnabert
  cgkt
```

### Remove a Project

```bash
work-remove <shortcut-or-name>
```

**Example:**
```bash
work-remove ana
# Removes all shortcuts for this project from config
# (Does NOT delete the actual directory)
```

### Get Help

```bash
work -h
# or
work --help
```

---

## Real-World Example

### Scenario: You're working on a new Linfoma project

```bash
# 1. Navigate to the project
cd /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS

# 2. Add it with meaningful shortcuts
work -a ana anamnesis lnf-ana

# Output:
# Adding project from current location...
#   Directory: /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS
#   Project name: anamnesis
#   Primary shortcut: ana
# ✓ Added shortcut: ana
# ✓ Added shortcut: anamnesis
# ✓ Added shortcut: lnf-ana
# ✓ Added to .gitignore: Documents/Lavoro/Linfoma/ANAMNESIS
#
# ✅ Project added successfully!
#
# Usage:
#   work ana
#   work anamnesis
#   work lnf-ana

# 3. From anywhere, jump to it
cd ~
work ana

# Output:
# ✓ Activated venv for ana
# 📂 Current directory: /home/gio/Documents/Lavoro/Linfoma/ANAMNESIS

# 4. If venv doesn't exist, create it
recreate-venv
```

---

## Configuration File

Projects are stored in: **`~/.zsh/work_projects.conf`**

### Format

```
shortcut:project_name:full_path
```

### Example Config

```bash
# Work Projects Configuration
# Format: shortcut:project_name:full_path

# Default Lavoro projects (auto-generated)
hdb:hyperdnabert:${LAVORO_DIR}/hyperdnabert
anamnesis:anamnesis:${LAVORO_DIR}/anamnesis
prism:prism_sr_hdnabert:${LAVORO_DIR}/prism_sr_hdnabert
cgkt:cgkt:${LAVORO_DIR}/cgkt

# Custom projects
ana:anamnesis:/home/gio/Documents/Lavoro/Linfoma/ANAMNESIS
lnf:linfoma:/home/gio/Documents/Lavoro/Linfoma
app:myapp:/home/gio/Projects/MyApp
```

### Environment Variables

The config supports environment variables:

```bash
${LAVORO_DIR}      # Expands to /home/gio/Documents/Lavoro
${HOME}            # Expands to /home/gio
$USER              # Expands to gio
```

---

## Git Integration

### Auto-exclusion from Git

When you add a project with `work -a`, it's **automatically added to `.gitignore`**:

```bash
work -a ana anamnesis
# Adds to ~/.dotfiles/.gitignore:
# Documents/Lavoro/Linfoma/ANAMNESIS/
```

### Config File Protection

The config file itself is excluded from git:

```gitignore
# In ~/.dotfiles/.gitignore
.zsh/work_projects.conf
```

This means:
- ✅ Your dotfiles can be pushed to GitHub
- ✅ Work projects stay private
- ✅ Project paths don't leak

---

## Advanced Usage

### Multiple Shortcuts for Organization

```bash
# Add project with company/category prefix
cd /home/gio/Documents/Lavoro/ClientX/ProjectY
work -a cx-py projecty clientx-projecty

# Now you can use:
work cx-py              # Short
work projecty           # Medium
work clientx-projecty   # Full
```

### Using Environment Variables

```bash
# Add using $HOME variable
cd $HOME/Projects/Important
work -a imp important

# In config, it stores the actual path:
# imp:important:/home/gio/Projects/Important
```

### Batch Operations

```bash
# List all projects
work -l > my-projects.txt

# Remove old projects
work-remove old-project-1
work-remove old-project-2
```

---

## Compatibility

### Legacy Commands Still Work

All old commands remain functional:

```bash
work-hdb        # Still works (calls: work hdb)
work-ana        # Still works (calls: work ana)
work-prism      # Still works (calls: work prism)
work-cgkt       # Still works (calls: work cgkt)
```

### Old Behavior Preserved

```bash
# Old way (still works)
work hyperdnabert

# This looks in:
# 1. Config file first (new)
# 2. Falls back to $LAVORO_DIR/hyperdnabert (old)
```

---

## Troubleshooting

### Project Not Found

```bash
work myproject
# Error: Project not found: myproject
#
# Available projects:
# ...
```

**Solution**: Check the project name with `work -l`

### Venv Not Activating

```bash
work ana
# ⚠️  No venv found in /path/to/project
# Run 'recreate-venv' to create one
```

**Solution**: Create the venv:
```bash
recreate-venv
```

### Config File Corrupted

If your config gets corrupted:

```bash
# Delete it (will be recreated with defaults)
rm ~/.zsh/work_projects.conf

# Reload shell
exec zsh

# Re-add your custom projects
cd /path/to/project
work -a shortcut name
```

### Wrong Directory

If a shortcut points to the wrong place:

```bash
# Remove the wrong entry
work-remove shortcut

# Re-add it from the correct location
cd /correct/path
work -a shortcut name
```

---

## Best Practices

### 1. Use Descriptive Shortcuts

```bash
# Good
work -a hdb hyperdnabert
work -a ana anamnesis

# Less clear
work -a x project1
work -a y project2
```

### 2. Consistent Naming

```bash
# Company/Category prefix
work -a acme-web acme-website
work -a acme-api acme-api
work -a acme-docs acme-documentation

# Project type suffix
work -a backend-api api-backend
work -a frontend-ui ui-frontend
```

### 3. Document Your Shortcuts

Add comments to the config file:

```bash
# Edit config
nvim ~/.zsh/work_projects.conf

# Add comments
# Client projects
acme:acme-website:/home/gio/Projects/Acme/Website

# Internal tools
tools:internal-tools:/home/gio/Tools
```

### 4. Backup Your Config

```bash
# Backup
cp ~/.zsh/work_projects.conf ~/work_projects_backup.conf

# Restore
cp ~/work_projects_backup.conf ~/.zsh/work_projects.conf
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `work -a <short> <name>` | Add current directory as project |
| `work <shortcut>` | Navigate to project |
| `work -l` | List all projects |
| `work -h` | Show help |
| `work-remove <name>` | Remove project from config |
| `recreate-venv` | Recreate Python virtual environment |
| `lavoro-ls` | Alias for `work -l` |

---

## Examples Cheat Sheet

```bash
# Add from current location
cd /path/to/project
work -a shortcut project-name

# Add with multiple shortcuts
work -a sh1 project sh2 sh3

# Navigate
work shortcut

# List all
work -l

# Remove
work-remove shortcut

# Create venv
cd /path/to/project
recreate-venv
```

---

**Your projects, your shortcuts, fully protected from git commits!** 🚀
