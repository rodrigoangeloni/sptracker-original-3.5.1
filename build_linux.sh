#!/bin/bash
# Build script for stracker on Linux/WSL
# Usage: ./build_linux.sh [version]

set -e  # Exit on error

VERSION="${1:-3.5.2}"

echo "========================================="
echo "🐧 Stracker Linux Build Script"
echo "========================================="
echo "Version: $VERSION"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if in WSL or native Linux
if grep -qi microsoft /proc/version; then
    echo -e "${YELLOW}ℹ️  Running in WSL${NC}"
else
    echo -e "${GREEN}✓${NC} Running on native Linux"
fi

# Check Python version
echo ""
echo "Checking Python version..."
if ! command -v python3.11 &> /dev/null; then
    echo -e "${RED}✗${NC} Python 3.11 not found!"
    echo "Please install Python 3.11:"
    echo "  sudo add-apt-repository ppa:deadsnakes/ppa"
    echo "  sudo apt install python3.11 python3.11-venv python3.11-dev"
    exit 1
fi

PYTHON_VERSION=$(python3.11 --version)
echo -e "${GREEN}✓${NC} $PYTHON_VERSION"

# Check if virtual environment exists
echo ""
echo "Checking virtual environment..."
if [ ! -d ".venv" ]; then
    echo -e "${YELLOW}⚠${NC}  Virtual environment not found. Creating..."
    python3.11 -m venv .venv
    echo -e "${GREEN}✓${NC} Virtual environment created"
else
    echo -e "${GREEN}✓${NC} Virtual environment exists"
fi

# Activate virtual environment
echo ""
echo "Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip
echo ""
echo "Upgrading pip..."
pip install --upgrade pip --quiet

# Check if requirements are installed
echo ""
echo "Checking dependencies..."
if ! pip show pyinstaller &> /dev/null; then
    echo -e "${YELLOW}⚠${NC}  Dependencies not installed. Installing..."
    pip install -r requirements.txt
    echo -e "${GREEN}✓${NC} Dependencies installed"
else
    echo -e "${GREEN}✓${NC} Dependencies already installed"
fi

# Verify all key packages
echo ""
echo "Verifying packages..."
packages=("pyinstaller" "apsw" "bottle" "cherrypy" "cheroot" "pygal")
for pkg in "${packages[@]}"; do
    if pip show "$pkg" &> /dev/null; then
        version=$(pip show "$pkg" | grep "Version:" | cut -d' ' -f2)
        echo -e "${GREEN}✓${NC} $pkg $version"
    else
        echo -e "${RED}✗${NC} $pkg not installed"
        exit 1
    fi
done

# Check if remote_settings.py exists
echo ""
echo "Checking configuration..."
if [ ! -f "remote_settings.py" ]; then
    echo -e "${YELLOW}⚠${NC}  remote_settings.py not found. Creating minimal version..."
    cat > remote_settings.py << 'EOF'
# Remote settings for Linux build
# Minimal configuration for local builds

remote_host = ""
remote_user = ""
remote_password = ""
remote_upload_directory = ""
EOF
    echo -e "${GREEN}✓${NC} remote_settings.py created"
else
    echo -e "${GREEN}✓${NC} remote_settings.py exists"
fi

# Clean previous build
echo ""
echo "Cleaning previous build..."
if [ -d "stracker/build" ]; then
    rm -rf stracker/build
    echo -e "${GREEN}✓${NC} Removed build directory"
fi
if [ -d "stracker/dist" ]; then
    rm -rf stracker/dist
    echo -e "${GREEN}✓${NC} Removed dist directory"
fi

# Build stracker
echo ""
echo "========================================="
echo "🔨 Building stracker for Linux..."
echo "========================================="
echo ""

python create_release.py --test_release_process --linux_only --stracker_only "$VERSION"

BUILD_EXIT_CODE=$?

if [ $BUILD_EXIT_CODE -ne 0 ]; then
    echo ""
    echo -e "${RED}✗ Build failed with exit code $BUILD_EXIT_CODE${NC}"
    exit $BUILD_EXIT_CODE
fi

# Verify binary was created
echo ""
echo "Verifying build..."
if [ ! -f "stracker/dist/stracker" ]; then
    echo -e "${RED}✗${NC} Binary not found at stracker/dist/stracker"
    exit 1
fi

# Make binary executable
chmod +x stracker/dist/stracker
echo -e "${GREEN}✓${NC} Binary is executable"

# Get binary size
BINARY_SIZE=$(du -h stracker/dist/stracker | cut -f1)
echo -e "${GREEN}✓${NC} Binary size: $BINARY_SIZE"

# Test binary
echo ""
echo "Testing binary..."
if stracker/dist/stracker --help > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Binary executes successfully"
else
    echo -e "${YELLOW}⚠${NC}  Binary test incomplete (may require configuration)"
fi

# Show dependencies
echo ""
echo "Checking binary dependencies..."
if command -v ldd &> /dev/null; then
    echo "Required system libraries:"
    ldd stracker/dist/stracker | grep -v "=>" | head -5
    echo "  ... (truncated)"
else
    echo -e "${YELLOW}⚠${NC}  ldd not available, skipping dependency check"
fi

# Summary
echo ""
echo "========================================="
echo "✅ Build Complete!"
echo "========================================="
echo ""
echo "Binary location: $(pwd)/stracker/dist/stracker"
echo "Binary size: $BINARY_SIZE"
echo "Python version: $PYTHON_VERSION"
echo ""
echo "Next steps:"
echo "  1. Test: cd stracker/dist && ./stracker --help"
echo "  2. Configure: cp stracker-default.ini stracker.ini"
echo "  3. Deploy to AC server"
echo ""
echo "For deployment help, see BUILD_LINUX.md"
echo ""
