#!/bin/bash

# NVIDIA GPU and CUDA Setup Script
# For Ubuntu 24.04 with NVIDIA drivers already installed

set -e

echo "═══════════════════════════════════════════════════════"
echo "    NVIDIA GPU & CUDA Setup"
echo "═══════════════════════════════════════════════════════"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Do not run this script as root/sudo"
    echo "The script will ask for sudo when needed"
    exit 1
fi

# Check for NVIDIA GPU
echo "🔍 Checking for NVIDIA GPU..."
if ! lspci | grep -i nvidia &>/dev/null; then
    echo "❌ No NVIDIA GPU detected"
    exit 1
fi

GPU_NAME=$(lspci | grep -i "VGA.*NVIDIA" | cut -d: -f3 | xargs)
echo "✓ Found GPU: $GPU_NAME"
echo ""

# Check NVIDIA driver
echo "🔍 Checking NVIDIA driver..."
if ! command -v nvidia-smi &>/dev/null; then
    echo "❌ NVIDIA drivers not installed"
    echo "Please install NVIDIA drivers first:"
    echo "  sudo ubuntu-drivers autoinstall"
    exit 1
fi

DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
CUDA_VERSION=$(nvidia-smi | grep "CUDA Version" | awk '{print $9}')
echo "✓ Driver Version: $DRIVER_VERSION"
echo "✓ CUDA Version (driver): $CUDA_VERSION"
echo ""

# Display GPU info
echo "📊 GPU Information:"
nvidia-smi --query-gpu=name,memory.total,compute_cap --format=csv,noheader
echo ""

# Check if CUDA toolkit is installed
echo "🔍 Checking CUDA toolkit..."
if command -v nvcc &>/dev/null; then
    NVCC_VERSION=$(nvcc --version | grep "release" | awk '{print $6}' | cut -d, -f1)
    echo "✓ CUDA toolkit already installed: $NVCC_VERSION"
    echo ""
    read -p "Reinstall CUDA toolkit? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping CUDA toolkit installation"
        SKIP_CUDA=1
    fi
else
    echo "⚠️  CUDA toolkit not installed"
    SKIP_CUDA=0
fi

# Install CUDA toolkit
if [ "$SKIP_CUDA" != "1" ]; then
    echo ""
    echo "📦 Installing CUDA toolkit..."
    echo ""

    sudo apt update
    sudo apt install -y \
        nvidia-cuda-toolkit \
        nvidia-cuda-toolkit-gcc \
        build-essential

    echo ""
    echo "✓ CUDA toolkit installed"

    # Verify installation
    if command -v nvcc &>/dev/null; then
        echo "✓ nvcc version: $(nvcc --version | grep release | awk '{print $6}')"
    else
        echo "⚠️  nvcc not found in PATH"
        echo "You may need to add CUDA to PATH:"
        echo "  export PATH=/usr/local/cuda/bin:\$PATH"
    fi
fi

# Check for cuDNN
echo ""
echo "🔍 Checking cuDNN (Deep Learning library)..."
if dpkg -l | grep -q cudnn; then
    echo "✓ cuDNN installed"
    dpkg -l | grep cudnn | awk '{print "  "$2" "$3}'
else
    echo "⚠️  cuDNN not installed"
    echo ""
    read -p "Install cuDNN? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing cuDNN..."
        sudo apt install -y libcudnn9-cuda-12 libcudnn9-dev-cuda-12
        echo "✓ cuDNN installed"
    fi
fi

# Python GPU libraries information
echo ""
echo "═══════════════════════════════════════════════════════"
echo "    Python GPU Libraries"
echo "═══════════════════════════════════════════════════════"
echo ""

echo "To use GPU in Python projects, install these in your venv:"
echo ""
echo "PyTorch (CUDA 12.x):"
echo "  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121"
echo ""
echo "TensorFlow (with GPU support):"
echo "  pip install tensorflow[and-cuda]"
echo ""
echo "JAX (with GPU support):"
echo "  pip install -U \"jax[cuda12]\""
echo ""
echo "Or for specific project:"
echo "  cd /path/to/project"
echo "  source venv/bin/activate"
echo "  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121"
echo ""

# Offer to install PyTorch globally (not recommended but available)
echo "═══════════════════════════════════════════════════════"
echo ""
read -p "Install PyTorch globally (NOT recommended, use venv instead)? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing PyTorch with CUDA support..."
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
    echo ""
    echo "Testing PyTorch GPU support..."
    python3 -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA available: {torch.cuda.is_available()}'); print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')"
fi

# Create GPU test script
echo ""
echo "📝 Creating GPU test script..."
cat > ~/test-gpu.py << 'EOF'
#!/usr/bin/env python3
"""
GPU Test Script
Tests NVIDIA GPU availability for common ML frameworks
"""

def test_pytorch():
    """Test PyTorch GPU support"""
    try:
        import torch
        print("=" * 60)
        print("PyTorch GPU Test")
        print("=" * 60)
        print(f"PyTorch version: {torch.__version__}")
        print(f"CUDA available: {torch.cuda.is_available()}")

        if torch.cuda.is_available():
            print(f"CUDA version: {torch.version.cuda}")
            print(f"cuDNN version: {torch.backends.cudnn.version()}")
            print(f"GPU count: {torch.cuda.device_count()}")
            print(f"Current GPU: {torch.cuda.current_device()}")
            print(f"GPU name: {torch.cuda.get_device_name(0)}")

            # Test tensor creation
            x = torch.randn(1000, 1000).cuda()
            y = torch.randn(1000, 1000).cuda()
            z = torch.mm(x, y)
            print(f"✓ GPU tensor operations working")
            print(f"  Device: {z.device}")
        else:
            print("❌ CUDA not available in PyTorch")
        print()
        return torch.cuda.is_available()
    except ImportError:
        print("⚠️  PyTorch not installed")
        print("   Install: pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121")
        print()
        return False

def test_tensorflow():
    """Test TensorFlow GPU support"""
    try:
        import tensorflow as tf
        print("=" * 60)
        print("TensorFlow GPU Test")
        print("=" * 60)
        print(f"TensorFlow version: {tf.__version__}")

        gpus = tf.config.list_physical_devices('GPU')
        print(f"GPU devices: {len(gpus)}")

        if gpus:
            for i, gpu in enumerate(gpus):
                print(f"  GPU {i}: {gpu.name}")

            # Test computation
            with tf.device('/GPU:0'):
                a = tf.constant([[1.0, 2.0], [3.0, 4.0]])
                b = tf.constant([[1.0, 1.0], [0.0, 1.0]])
                c = tf.matmul(a, b)
            print(f"✓ GPU tensor operations working")
        else:
            print("❌ No GPU devices found in TensorFlow")
        print()
        return len(gpus) > 0
    except ImportError:
        print("⚠️  TensorFlow not installed")
        print("   Install: pip install tensorflow[and-cuda]")
        print()
        return False

def test_jax():
    """Test JAX GPU support"""
    try:
        import jax
        print("=" * 60)
        print("JAX GPU Test")
        print("=" * 60)
        print(f"JAX version: {jax.__version__}")

        devices = jax.devices()
        print(f"Devices: {devices}")

        gpu_devices = [d for d in devices if d.platform == 'gpu']
        if gpu_devices:
            print(f"GPU devices: {len(gpu_devices)}")
            for i, gpu in enumerate(gpu_devices):
                print(f"  GPU {i}: {gpu}")
            print("✓ JAX GPU support working")
        else:
            print("❌ No GPU devices in JAX")
        print()
        return len(gpu_devices) > 0
    except ImportError:
        print("⚠️  JAX not installed")
        print('   Install: pip install -U "jax[cuda12]"')
        print()
        return False

def main():
    """Run all GPU tests"""
    print("\n" + "=" * 60)
    print("  GPU Test Suite")
    print("=" * 60)
    print()

    results = {
        'PyTorch': test_pytorch(),
        'TensorFlow': test_tensorflow(),
        'JAX': test_jax()
    }

    print("=" * 60)
    print("Summary")
    print("=" * 60)
    for framework, working in results.items():
        status = "✓ Working" if working else "✗ Not working / Not installed"
        print(f"{framework:15} {status}")
    print()

if __name__ == "__main__":
    main()
EOF

chmod +x ~/test-gpu.py
echo "✓ Created ~/test-gpu.py"
echo ""

# System monitoring tools
echo "═══════════════════════════════════════════════════════"
echo "    GPU Monitoring"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Monitor GPU usage:"
echo "  nvidia-smi                    # One-time snapshot"
echo "  watch -n1 nvidia-smi          # Real-time monitoring"
echo "  nvtop                         # Interactive GPU monitor (install: sudo apt install nvtop)"
echo ""
echo "Your i3 status bar already shows GPU stats!"
echo ""

# Environment variables
echo "═══════════════════════════════════════════════════════"
echo "    Environment Variables (Optional)"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Add to ~/.zshrc if needed:"
echo ""
echo "  # CUDA paths"
echo "  export PATH=/usr/local/cuda/bin:\$PATH"
echo "  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH"
echo ""
echo "  # Optimize GPU usage"
echo "  export CUDA_VISIBLE_DEVICES=0  # Use first GPU only"
echo ""

# Final summary
echo "═══════════════════════════════════════════════════════"
echo "✅ GPU Setup Complete!"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Summary:"
echo "  GPU: $GPU_NAME"
echo "  Driver: $DRIVER_VERSION"
echo "  CUDA: $CUDA_VERSION"
echo ""
echo "Next steps:"
echo "  1. Install GPU libraries in your Python venv:"
echo "     work ana  # or your project"
echo "     pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121"
echo ""
echo "  2. Test GPU support:"
echo "     python3 ~/test-gpu.py"
echo ""
echo "  3. Monitor GPU:"
echo "     nvidia-smi"
echo ""
