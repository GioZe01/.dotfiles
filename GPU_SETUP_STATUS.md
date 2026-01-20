# GPU Setup Status

## ✅ Current Status

### NVIDIA GPU Detected
- **GPU**: NVIDIA GeForce RTX 5070 Ti
- **VRAM**: 16 GB
- **Driver Version**: 580.95.05 ✅ **INSTALLED**
- **CUDA Version (Driver)**: 13.0 ✅ **READY**
- **Status**: Active and working

### What's Already Installed
✅ **NVIDIA Drivers** - Version 580.95.05 (latest)
✅ **nvidia-smi** - Working perfectly
✅ **GPU in use** - Currently running X.org, Alacritty, Mattermost

### What's NOT Installed
❌ **CUDA Toolkit** - Development tools (nvcc compiler)
❌ **cuDNN** - Deep Learning library
❌ **PyTorch** - GPU support for Python
❌ **TensorFlow** - GPU support for Python

---

## 🚀 How to Complete GPU Setup

### Option 1: Automated Setup (Recommended)

Run the GPU setup script:

```bash
cd ~/.dotfiles
bash scripts/setup-gpu.sh
```

**What it does:**
1. ✅ Verifies GPU and drivers (already done)
2. 📦 Installs CUDA toolkit (nvcc, libraries)
3. 📦 Installs cuDNN (deep learning acceleration)
4. 📝 Creates GPU test script
5. 📊 Shows installation instructions for PyTorch/TensorFlow

**Time**: ~5-10 minutes (depends on download speed)

### Option 2: Manual Installation

#### Install CUDA Toolkit
```bash
sudo apt update
sudo apt install -y nvidia-cuda-toolkit nvidia-cuda-toolkit-gcc build-essential
```

#### Install cuDNN (optional but recommended for deep learning)
```bash
sudo apt install -y libcudnn9-cuda-12 libcudnn9-dev-cuda-12
```

#### Verify CUDA
```bash
nvcc --version
# Should show: release 12.0
```

---

## 🐍 Python GPU Libraries

### For PyTorch Projects

```bash
# Navigate to your project
work ana  # or cd /path/to/project

# Activate venv
source venv/bin/activate

# Install PyTorch with CUDA 12.x support
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

**Test PyTorch GPU:**
```python
import torch
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"GPU name: {torch.cuda.get_device_name(0)}")

# Test computation
x = torch.randn(1000, 1000).cuda()
y = torch.randn(1000, 1000).cuda()
z = torch.mm(x, y)
print(f"Computation on: {z.device}")  # Should show: cuda:0
```

### For TensorFlow Projects

```bash
# In your venv
pip install tensorflow[and-cuda]
```

**Test TensorFlow GPU:**
```python
import tensorflow as tf
print(tf.config.list_physical_devices('GPU'))
# Should show: [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

### For JAX Projects

```bash
# In your venv
pip install -U "jax[cuda12]"
```

**Test JAX GPU:**
```python
import jax
print(jax.devices())
# Should show GPU devices
```

---

## 📊 Monitoring GPU

### Real-time Monitoring

```bash
# Basic info
nvidia-smi

# Real-time monitoring (updates every 1 second)
watch -n1 nvidia-smi

# Interactive monitor (install first)
sudo apt install nvtop
nvtop
```

### i3 Status Bar

Your i3 status bar already shows:
- GPU Utilization %
- GPU Temperature
- GPU Memory Usage

Configured in: `~/.config/i3/scripts/i3status-wrapper.sh`

---

## 🎯 Quick Commands

```bash
# Check GPU info
nvidia-smi

# Install CUDA toolkit
sudo apt install nvidia-cuda-toolkit

# Test GPU with Python (after setup)
python3 ~/test-gpu.py

# Monitor GPU usage
watch -n1 nvidia-smi
```

---

## 📝 Current GPU Usage

```
Processes using GPU:
  - Xorg (319 MB) - Display server
  - Alacritty (10 MB) - Terminal
  - Mattermost (40 MB) - Desktop app
  - Firefox (56 MB) - Browser

Total GPU Memory Used: 494 MB / 16303 MB (3%)
GPU Utilization: 0% (idle)
Temperature: 39°C
Power: 23W / 300W
```

---

## 🔧 Troubleshooting

### CUDA Not Found After Install

Add to `~/.zshrc`:
```bash
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

Then reload:
```bash
source ~/.zshrc
```

### PyTorch Not Seeing GPU

```bash
# Reinstall with correct CUDA version
pip uninstall torch torchvision torchaudio
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

### Check CUDA Version Compatibility

```bash
# Driver CUDA version (what your driver supports)
nvidia-smi | grep "CUDA Version"

# Toolkit CUDA version (what's installed)
nvcc --version

# PyTorch CUDA version (what PyTorch is using)
python -c "import torch; print(torch.version.cuda)"
```

**Note**: Driver version >= Toolkit version >= PyTorch version

---

## 💡 Best Practices

### 1. Use Virtual Environments

**Always install GPU libraries in project venvs, not globally:**

```bash
work ana
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

### 2. Specify GPU Device

```python
# Use specific GPU (if you have multiple)
import torch
device = torch.device('cuda:0')  # First GPU
model = model.to(device)
```

### 3. Clear GPU Memory

```python
import torch

# Clear cache
torch.cuda.empty_cache()

# Check memory
print(torch.cuda.memory_allocated())
print(torch.cuda.memory_reserved())
```

### 4. Monitor While Training

```bash
# In one terminal: start training
python train.py

# In another terminal: monitor GPU
watch -n1 nvidia-smi
```

---

## 📚 Useful Links

- **NVIDIA Drivers**: https://www.nvidia.com/Download/index.aspx
- **CUDA Toolkit**: https://developer.nvidia.com/cuda-downloads
- **PyTorch GPU**: https://pytorch.org/get-started/locally/
- **TensorFlow GPU**: https://www.tensorflow.org/install/gpu
- **JAX GPU**: https://jax.readthedocs.io/en/latest/installation.html

---

## ✅ Next Steps

1. **Run the setup script:**
   ```bash
   bash ~/.dotfiles/scripts/setup-gpu.sh
   ```

2. **Install PyTorch in your project:**
   ```bash
   work ana
   pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
   ```

3. **Test GPU support:**
   ```bash
   python3 ~/test-gpu.py
   ```

4. **Start training with GPU! 🚀**

---

**Your RTX 5070 Ti is ready for deep learning!** 🎮🔥
