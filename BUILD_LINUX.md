# Building Stracker on Linux/WSL

This guide shows how to compile stracker for Linux using WSL (Windows Subsystem for Linux) or native Linux.

## Prerequisites

### 1. Install WSL (if on Windows)

```bash
# In PowerShell (as Administrator)
wsl --install -d Ubuntu-22.04
```

### 2. Open WSL Terminal

```bash
# Launch Ubuntu from Start Menu or
wsl
```

### 3. Update System

```bash
sudo apt update
sudo apt upgrade -y
```

### 4. Install Python 3.11

```bash
# Add deadsnakes PPA for Python 3.11
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update

# Install Python 3.11 and dependencies
sudo apt install python3.11 python3.11-venv python3.11-dev -y

# Install pip for Python 3.11
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
```

### 5. Install Build Dependencies

```bash
# Essential build tools
sudo apt install build-essential -y

# PostgreSQL client libraries (for psycopg2)
sudo apt install libpq-dev -y

# SQLite development files (for apsw)
sudo apt install libsqlite3-dev -y

# Additional dependencies
sudo apt install git wget curl -y
```

## Build Process

### 1. Clone Repository (if not already done)

```bash
# Navigate to your workspace
cd ~
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1

# Or if already cloned on Windows, navigate to the WSL path:
cd /mnt/c/Users/Rodrigo.DESKTOP-I1TEA6K/source/repos/sptracker-original-3.5.1
```

### 2. Create Virtual Environment

```bash
# Create venv with Python 3.11
python3.11 -m venv .venv

# Activate virtual environment
source .venv/bin/activate

# Verify Python version
python --version  # Should show Python 3.11.x
```

### 3. Install Python Dependencies

```bash
# Upgrade pip
pip install --upgrade pip

# Install all requirements
pip install -r requirements.txt
```

**Note**: If `apsw` fails to compile, you may need:

```bash
# Install additional dependencies for APSW
sudo apt install python3.11-distutils -y

# Try installing APSW separately
pip install apsw --no-binary apsw
```

### 4. Create remote_settings.py (if missing)

```bash
# Create minimal configuration for Linux-only build
cat > remote_settings.py << 'EOF'
# Remote settings for Linux build
# Minimal configuration - only building, not uploading

# These can be empty for test builds
remote_host = ""
remote_user = ""
remote_password = ""
remote_upload_directory = ""
EOF
```

### 5. Build stracker for Linux

```bash
# Test build (doesn't create release package)
python create_release.py --test_release_process --linux_only --stracker_only 3.5.2
```

### 6. PyInstaller Output Location

After successful build:

```
stracker/dist/stracker  (Linux executable)
```

### 7. Create Distribution Package (Optional)

```bash
# For production release without --test_release_process
python create_release.py --linux_only --stracker_only 3.5.2
```

This creates: `versions/stracker-V3.5.2.zip` containing `stracker_linux_x86.tgz`

## Testing the Linux Binary

### 1. Test Locally

```bash
cd stracker/dist
./stracker --help
```

### 2. Expected Output

```
Usage: stracker [options]
Options:
  --help            show this help message and exit
  ...
```

### 3. Test with Configuration

```bash
# Copy default config
cp stracker/stracker-default.ini stracker/dist/stracker.ini

# Edit configuration
nano stracker/dist/stracker.ini

# Run stracker
cd stracker/dist
./stracker
```

## Common Issues and Solutions

### Issue 1: APSW Compilation Fails

**Error**: `error: command 'gcc' failed`

**Solution**:
```bash
sudo apt install build-essential python3.11-dev libsqlite3-dev -y
pip install --upgrade pip setuptools wheel
pip install apsw --no-binary apsw
```

### Issue 2: psycopg2 Compilation Fails

**Error**: `Error: pg_config executable not found`

**Solution**:
```bash
sudo apt install libpq-dev -y
pip install psycopg2-binary  # Use binary version
```

### Issue 3: PyInstaller "command not found"

**Error**: `pyinstaller: command not found`

**Solution**:
```bash
# Make sure venv is activated
source .venv/bin/activate

# Reinstall PyInstaller
pip install --force-reinstall pyinstaller
```

### Issue 4: Permission Denied on stracker Binary

**Error**: `bash: ./stracker: Permission denied`

**Solution**:
```bash
chmod +x stracker/dist/stracker
```

### Issue 5: _imagingft.pyd Warning (python33.dll)

**Warning**: `Library not found: could not resolve 'python33.dll'`

**Solution**: This is a **harmless warning**. It's a legacy dependency from PIL/Pillow for the old Python 3.3 version. The binary will work correctly without it.

## Performance Notes

### Building in WSL vs Native Linux

- **WSL**: Slightly slower I/O due to filesystem translation
- **Native Linux**: Faster, especially for large compilations
- **Both**: Produce identical binaries

### Optimization Flags

For optimized builds, you can modify `create_release.py`:

```python
# Around line 250, modify the pyinstaller command to add:
--strip  # Reduces binary size
--onefile  # Already included
```

## Cross-Platform Notes

### Windows vs Linux Binary Differences

| Feature | Windows (.exe) | Linux (ELF) |
|---------|---------------|-------------|
| File Extension | `.exe` | (none) |
| Size | ~20-25 MB | ~25-30 MB |
| Dependencies | Bundled DLLs | System libraries |
| Compatibility | Windows 10+ | Ubuntu 18.04+ |

### Database Compatibility

Both Windows and Linux binaries use the **same database format**:
- ✅ SQLite `.db3` files are cross-platform
- ✅ PostgreSQL works identically
- ✅ Can share database between Windows and Linux servers

## Deployment to Linux Server

### Method 1: Direct Copy

```bash
# From WSL to Linux server
scp stracker/dist/stracker user@server:/path/to/acserver/stracker/

# Don't forget additional files
scp -r stracker/http_static user@server:/path/to/acserver/stracker/
scp -r stracker/http_templates user@server:/path/to/acserver/stracker/
scp stracker/stracker-default.ini user@server:/path/to/acserver/stracker/stracker.ini
```

### Method 2: Using Distribution Package

```bash
# Build full package
python create_release.py --linux_only --stracker_only 3.5.2

# Extract stracker_linux_x86.tgz on server
scp versions/stracker-V3.5.2.zip user@server:/tmp/
ssh user@server
cd /tmp
unzip stracker-V3.5.2.zip
tar xzf stracker_linux_x86.tgz -C /path/to/acserver/
```

## Automation Script

Create `build_linux.sh`:

```bash
#!/bin/bash
set -e

echo "🐧 Building stracker for Linux..."

# Activate venv
source .venv/bin/activate

# Verify Python version
python --version

# Build
python create_release.py --test_release_process --linux_only --stracker_only 3.5.2

# Test binary
echo "✅ Testing binary..."
cd stracker/dist
./stracker --help

echo "✅ Build complete!"
echo "Binary location: $(pwd)/stracker"
```

Make it executable:

```bash
chmod +x build_linux.sh
./build_linux.sh
```

## Next Steps

After successful build:

1. ✅ Test the binary locally with `./stracker --help`
2. ✅ Configure `stracker.ini` for your server
3. ✅ Deploy to Linux Assetto Corsa server
4. ✅ Test with actual AC server
5. ✅ Monitor logs for any issues

## Resources

- [PyInstaller Linux Documentation](https://pyinstaller.org/en/stable/usage.html)
- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [APSW Documentation](https://rogerbinns.github.io/apsw/)

## Support

For issues specific to Linux builds, check:
- PyInstaller compatibility with your Linux distribution
- Missing system libraries (`ldd stracker/dist/stracker`)
- Python 3.11 availability on target system

---

**Built with ❤️ for the Assetto Corsa community**
