# Neovim for Data Science, Machine Learning & Bioinformatics

Complete guide to using Neovim for Python data science, PyTorch/ML training, and bioinformatics workflows.

---

## Overview

This setup integrates Neovim with:
- **Jupyter Notebooks** - Interactive code execution with molten.nvim
- **PyTorch/ML** - Tensor visualization and training workflows
- **Image Viewing** - View plots, tensors, and images in terminal
- **Bioinformatics** - Syntax highlighting for FASTQ, FASTA, SAM, VCF, etc.
- **Database Tools** - SQL client for data analysis
- **CSV/TSV** - Structured viewing of tabular data

---

## Plugin Summary

### Jupyter Notebook Integration

| Plugin | Purpose | Features |
|--------|---------|----------|
| **molten.nvim** | Interactive code execution | Run Python/Julia/R code cells, inline outputs |
| **jupytext.nvim** | Edit .ipynb as .py | Convert between formats, sync with notebooks |
| **image.nvim** | Display images in terminal | View plots, matplotlib figures, PNG/JPG |

### Machine Learning

| Plugin | Purpose | Features |
|--------|---------|----------|
| **venv-selector.nvim** | Python environment management | Auto-detect venvs, Telescope integration |
| **dispy.nvim** | PyTorch tensor visualization | View tensors, plot data, statistics (manual install) |

### Bioinformatics

| Plugin | Purpose | Features |
|--------|---------|----------|
| **bioSyntax** | Bioinformatics syntax highlighting | FASTQ, FASTA, SAM, VCF, GTF, BED, PDB (system install) |

### Data Tools

| Plugin | Purpose | Features |
|--------|---------|----------|
| **csv.vim** | CSV/TSV viewer | Column alignment, delimiter detection |
| **vim-dadbod-ui** | Database client | SQL queries, table browsing, connections |
| **markdown-preview.nvim** | Markdown preview | Live preview in browser |

---

## Installation

### 1. Core Plugins (Automatic)

The plugins in `datascience.lua` will install automatically when you run:

```vim
:Lazy sync
```

### 2. Terminal Requirements

**For Image Viewing (image.nvim, molten.nvim):**

You need **Kitty terminal** or **ueberzug++**:

```bash
# Option 1: Install Kitty (recommended)
sudo apt install kitty

# Option 2: Install ueberzug++ (alternative)
pip install ueberzug
```

**For Jupyter Integration:**

```bash
# Install Jupyter and required packages
pip install jupyter pynvim jupyter_client cairosvg pnglatex plotly kaleido pyperclip pillow

# For molten.nvim
pip install jupyter-client
```

### 3. bioSyntax (Manual Installation)

Install bioSyntax for bioinformatics file syntax highlighting:

```bash
# Clone repository
cd ~/Downloads
git clone https://github.com/bioSyntax/bioSyntax.git
cd bioSyntax

# Run installer
./bioSyntax_INSTALL.sh vim

# Or for Neovim specifically
./bioSyntax_INSTALL.sh nvim
```

Supported formats: `.fasta`, `.fastq`, `.sam`, `.vcf`, `.gtf`, `.bed`, `.pdb`, `.cwl`

**Sources:**
- [bioSyntax GitHub](https://github.com/bioSyntax/bioSyntax)
- [bioSyntax Website](https://biosyntax.org/)
- [bioSyntax Manual](https://biosyntax.org/man.html)

### 4. dispy.nvim (Optional - PyTorch Tensor Visualization)

For PyTorch tensor visualization:

```bash
# Clone manually
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
cd ~/.local/share/nvim/site/pack/plugins/start
git clone https://github.com/calebmcirvin/dispy.nvim.git
```

Then uncomment the dispy.nvim section in `datascience.lua`.

**Source:** [dispy.nvim](https://www.calebmcirvin.com/posts/dispynvim/)

---

## Keybindings

### Molten (Jupyter Integration)

| Keybinding | Mode | Action |
|------------|------|--------|
| `<leader>mi` | Normal | Initialize Molten kernel |
| `<leader>me` | Normal | Evaluate operator |
| `<leader>ml` | Normal | Evaluate current line |
| `<leader>mr` | Normal | Re-evaluate cell |
| `<leader>md` | Normal | Delete cell |
| `<leader>mo` | Normal | Show cell output |
| `<leader>mh` | Normal | Hide cell output |
| `<leader>mv` | Visual | Evaluate visual selection |

### Python Virtual Environments

| Keybinding | Mode | Action |
|------------|------|--------|
| `<leader>vs` | Normal | Select Python venv (Telescope) |
| `<leader>vc` | Normal | Select cached venv |

### Markdown Preview

| Keybinding | Mode | Action |
|------------|------|--------|
| `<leader>mp` | Normal | Open Markdown preview |
| `<leader>ms` | Normal | Stop Markdown preview |

### Database

| Keybinding | Mode | Action |
|------------|------|--------|
| `<leader>db` | Normal | Toggle Database UI |

---

## Workflows

### 1. Jupyter Notebook Workflow

#### Method A: Using Molten (Recommended)

```vim
" Open a Python file
:e analysis.py

" Initialize Jupyter kernel
<leader>mi

" Write code in buffer
import numpy as np
import matplotlib.pyplot as plt

# Mark code sections with comments
# %%
data = np.random.randn(100)
plt.hist(data)
plt.show()

" Run code cell
<leader>ml    (run line)
<leader>mv    (run visual selection)

" View output
<leader>mo

" Images will appear inline if using Kitty terminal
```

#### Method B: Edit .ipynb Files Directly

```vim
" Open notebook (jupytext converts to .py automatically)
:e notebook.ipynb

" Edit as regular Python file
" On save, changes sync back to .ipynb

" Convert styles available:
" - hydrogen: # %% cell markers
" - markdown: markdown cells preserved
" - percent: # %% style
```

### 2. PyTorch Training Workflow

```python
# training.py
import torch
import torch.nn as nn

# Define model
model = nn.Sequential(
    nn.Linear(784, 128),
    nn.ReLU(),
    nn.Linear(128, 10)
)

# Training loop
for epoch in range(10):
    # Training code
    loss = train_step(model, data)

    # With dispy.nvim: visualize tensors inline
    # (Requires dispy plugin installed)
    print(f"Epoch {epoch}, Loss: {loss.item()}")

# %%
# Test visualization
# Run this cell to see tensor values
model[0].weight
```

**Using with work() function:**
```bash
# Start ML project with venv and Neovim session
work -e hyperdnabert

# Inside nvim:
<leader>vs    # Select venv if needed
<leader>mi    # Initialize Jupyter kernel
# Start coding and running cells interactively
```

### 3. Bioinformatics Workflow

After installing bioSyntax:

```vim
" Open FASTQ file
:e sample.fastq

" Syntax highlighting automatically applied
" - PHRED quality scores color-coded (black=low, white=high)
" - Sequence bases highlighted
" - Headers clearly marked

" Open FASTA file
:e genome.fasta

" Work with other formats
:e alignment.sam
:e variants.vcf
:e genes.gtf
```

**Supported formats:**
- `.fasta` / `.fa` - Sequence data
- `.fastq` / `.fq` - Sequencing reads with quality
- `.sam` / `.bam` - Sequence alignments
- `.vcf` - Variant calls
- `.gtf` / `.gff` - Gene annotations
- `.bed` - Genomic regions
- `.pdb` - Protein structures
- `.cwl` - Common Workflow Language

### 4. Data Analysis Workflow

#### Working with CSV/TSV files

```vim
" Open CSV file
:e data.csv

" csv.vim automatically activates
" - Columns are aligned
" - Navigate between columns with W/B
" - Sort, filter, analyze columns

" Commands in csv.vim
:ArrangeColumn    " Align columns
:UnArrangeColumn  " Remove alignment
:DeleteColumn     " Delete column
:CSVInit          " Reinitialize
```

#### Database Queries

```vim
" Open database UI
<leader>db

" Add connection (in DBUI)
Press A

" Example connection strings:
" PostgreSQL: postgresql://user:password@localhost:5432/database
" MySQL: mysql://user:password@localhost:3306/database
" SQLite: sqlite:///path/to/database.db

" Navigate and query
" - <CR> to open table
" - S to execute SQL
" - Results appear in split
```

### 5. Image Viewing Workflow

```vim
" View PNG/JPG images in Neovim (requires Kitty terminal)
:e plot.png

" Image appears inline in buffer

" View matplotlib output
" In Python code:
import matplotlib.pyplot as plt
plt.plot([1, 2, 3])
plt.savefig('output.png')
plt.show()

" Then in Neovim:
:e output.png
```

---

## Configuration

### Molten Configuration

Edit `~/.dotfiles/nvim/.config/nvim/lua/config/plugins/datascience.lua`:

```lua
vim.g.molten_image_provider = "image.nvim"  -- or "none"
vim.g.molten_output_win_max_height = 20
vim.g.molten_auto_open_output = false
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
```

### Image.nvim Configuration

```lua
opts = {
    backend = "kitty",  -- or "ueberzug"
    max_height_window_percentage = 50,
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
}
```

### Jupytext Style

```lua
style = "hydrogen",  -- "hydrogen" | "markdown" | "light" | "percent"
```

---

## Troubleshooting

### Molten: "Kernel not found"

```bash
# Install Jupyter and dependencies
pip install jupyter jupyter_client pynvim

# Check installed kernels
jupyter kernelspec list

# Install Python kernel
python -m ipykernel install --user --name myenv
```

### Image.nvim: Images not showing

```bash
# Check terminal
echo $TERM  # Should be "xterm-kitty" for Kitty

# Test kitty graphics protocol
kitty +kitten icat image.png

# If not using Kitty, install ueberzug++
pip install ueberzug

# Change backend in datascience.lua:
backend = "ueberzug",
```

### bioSyntax: Not highlighting

```vim
" Check if bioSyntax is installed
:scriptnames | grep biosyntax

" Manually set filetype
:set ft=fasta
:set ft=fastq

" Reinstall bioSyntax
# Run installation script again
cd ~/Downloads/bioSyntax
./bioSyntax_INSTALL.sh nvim
```

### LSP: Pyright not finding imports

```vim
" Select correct venv
<leader>vs

" Restart LSP
:LspRestart

" Check pyright config
:e pyrightconfig.json
{
  "venvPath": ".",
  "venv": "venv"
}
```

### CSV: Columns not aligned

```vim
" Reinitialize CSV plugin
:CSVInit

" Manually arrange
:ArrangeColumn

" Check delimiter
:let g:csv_delim = ','
```

---

## Integration with work() Function

The new plugins work seamlessly with the enhanced `work()` function:

```bash
# Start ML project
work -e hyperdnabert

# Neovim opens with:
# - Session restored
# - Python venv activated
# - LSP connected to venv
# - Ready for Jupyter workflow

# Inside Neovim:
<leader>vs   # Confirm venv (should show activated one)
<leader>mi   # Initialize Molten kernel
# Start coding with inline execution
```

---

## Best Practices

### 1. Project Structure for Data Science

```
project/
├── venv/                 # Python virtual environment
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/            # .ipynb files (edit as .py with jupytext)
├── src/
│   ├── models/
│   ├── training/
│   └── utils/
├── tests/
├── outputs/
│   ├── plots/
│   └── models/
└── pyproject.toml
```

### 2. Cell Markers for Molten

Use `# %%` to mark code cells:

```python
# %%
import pandas as pd
data = pd.read_csv('data.csv')

# %%
# Exploratory analysis
data.describe()

# %%
# Visualization
import matplotlib.pyplot as plt
data.plot()
plt.show()
```

### 3. PyTorch Training Sessions

```python
# training.py

# %%
# Imports and setup
import torch
import torch.nn as nn
from torch.utils.data import DataLoader

# %%
# Model definition
model = MyModel()

# %%
# Training loop (run incrementally)
for epoch in range(epochs):
    loss = train_epoch(model, data)
    print(f"Epoch {epoch}: {loss}")

# %%
# Evaluation
evaluate(model, test_data)

# %%
# Save model
torch.save(model.state_dict(), 'model.pth')
```

Run each section with `<leader>ml` or select multiple lines and `<leader>mv`.

### 4. Bioinformatics Analysis

```bash
# Use work() to start bioinformatics project
work -e anamnesis

# Inside Neovim:
:e data/sample.fastq    # View sequencing data with quality colors
:e data/genome.fasta    # View reference genome
:e results/variants.vcf # View variant calls
:term                   # Run bioinformatics tools
```

---

## Resources

### Plugin Documentation

- [molten.nvim](https://github.com/benlubas/molten-nvim)
- [jupytext.nvim](https://github.com/GCBallesteros/jupytext.nvim)
- [image.nvim](https://github.com/3rd/image.nvim)
- [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim)
- [bioSyntax](https://biosyntax.org/)
- [csv.vim](https://github.com/chrisbra/csv.vim)
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)

### Articles & Guides

- [Neovim Setups for Data Science (Medium)](https://medium.com/geekculture/neovim-setups-for-data-science-5ea251e3735f)
- [Molten.nvim Transforms NeoVim into Jupyter-Like Experience](https://medium.com/@CompXBio/data-science-series-2-molten-nvim-transforms-neovim-into-a-jupyter-like-experience-a6435e6f2db7)
- [dispy.nvim - PyTorch Tensor Visualization](https://www.calebmcirvin.com/posts/dispynvim/)
- [bioSyntax - Bioinformatics Syntax Highlighting](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-018-2315-y)

### Terminal Emulators

- [Kitty - GPU Terminal](https://sw.kovidgoyal.net/kitty/)
- [Wezterm - Alternative](https://wezfurlong.org/wezterm/)

---

## Quick Reference

```
DATA SCIENCE SHORTCUTS:

JUPYTER/MOLTEN:
<leader>mi          → Initialize kernel
<leader>ml          → Run line
<leader>mv          → Run visual selection
<leader>mo          → Show output
<leader>mr          → Re-run cell

PYTHON ENV:
<leader>vs          → Select venv
<leader>vc          → Cached venv

MARKDOWN:
<leader>mp          → Preview
<leader>ms          → Stop preview

DATABASE:
<leader>db          → DB UI

FILES:
.ipynb              → Auto-convert with jupytext
.fastq/.fasta       → bioSyntax highlighting
.csv/.tsv           → csv.vim alignment
.png/.jpg           → image.nvim viewing
```

---

**Note**: This setup requires Kitty terminal or ueberzug++ for image display. For best experience, use Kitty terminal emulator with the enhanced `work -e` command.
