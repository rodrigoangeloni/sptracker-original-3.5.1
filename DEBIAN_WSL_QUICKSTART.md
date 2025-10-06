# Quick Start: Build stracker on Debian 12 (WSL)

## Post-Installation Setup

After Debian installs and prompts for username/password, run these commands:

### 1. Update System
```bash
sudo apt update
sudo apt upgrade -y
```

### 2. Install Python 3.11
```bash
# Install dependencies
sudo apt install -y software-properties-common wget curl build-essential

# Python 3.11 is in Debian 12 (bookworm) by default
sudo apt install -y python3.11 python3.11-venv python3.11-dev

# Verify
python3.11 --version
```

### 3. Install Build Dependencies
```bash
# PostgreSQL client libraries
sudo apt install -y libpq-dev

# SQLite development files
sudo apt install -y libsqlite3-dev

# Git
sudo apt install -y git
```

### 4. Navigate to Project (via Windows mount)
```bash
cd /mnt/c/Users/Rodrigo.DESKTOP-I1TEA6K/source/repos/sptracker-original-3.5.1
```

### 5. Make build script executable
```bash
chmod +x build_linux.sh
```

### 6. Run the build!
```bash
./build_linux.sh 3.5.2
```

## Alternative: Manual Build

If the script has issues:

```bash
# Create virtualenv
python3.11 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Build
python create_release.py --test_release_process --linux_only --stracker_only 3.5.2
```

## Expected Result

```
stracker/dist/stracker (Linux ELF executable, ~25-30 MB)
```

## Test the binary

```bash
cd stracker/dist
./stracker --help
```

## Troubleshooting

### Issue: APSW won't compile
```bash
pip install --no-binary apsw apsw
```

### Issue: Permission denied
```bash
chmod +x stracker/dist/stracker
```

### Issue: Line endings (CRLF vs LF)
```bash
# Convert build_linux.sh to Unix format
sudo apt install dos2unix
dos2unix build_linux.sh
```

## Next Steps

1. ✅ Binary builds successfully
2. ✅ Test locally with `--help`
3. ✅ Deploy to your Assetto Corsa Linux server
4. ✅ Configure and enjoy!

---

**Note**: The Windows .venv won't work in WSL. The build script will create a new Linux-specific virtualenv automatically.
