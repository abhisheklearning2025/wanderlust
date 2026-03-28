#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Wanderlust AI — iOS Build & Install   ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Step 1: Check Flutter
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Error: Flutter not found in PATH.${NC}"
    exit 1
fi

# Step 2: Check for connected iOS device
echo -e "${YELLOW}[1/5] Checking for connected iOS device...${NC}"
IOS_DEVICE=$(flutter devices 2>/dev/null | grep -i "ios\|iPhone\|iPad" | grep -v "Simulator" | head -1)

if [ -z "$IOS_DEVICE" ]; then
    echo -e "${RED}No physical iOS device found.${NC}"
    echo ""
    echo "Make sure:"
    echo "  1. iPhone/iPad is connected via USB"
    echo "  2. Device is unlocked and trusts this computer"
    echo "  3. Run: flutter devices"
    echo ""
    exit 1
fi

DEVICE_ID=$(echo "$IOS_DEVICE" | awk -F'•' '{print $2}' | xargs)
DEVICE_NAME=$(echo "$IOS_DEVICE" | awk -F'•' '{print $1}' | xargs)
echo -e "${GREEN}Found: $DEVICE_NAME ($DEVICE_ID)${NC}"

# Step 3: Check signing
echo ""
echo -e "${YELLOW}[2/5] Checking code signing...${NC}"
IDENTITIES=$(security find-identity -v -p codesigning 2>/dev/null | grep "valid identities" | awk '{print $1}')

if [ "$IDENTITIES" = "0" ]; then
    echo -e "${RED}No code signing identities found.${NC}"
    echo ""
    echo "To fix this, open Xcode and set up signing:"
    echo "  1. Open Xcode → Settings → Accounts → Add your Apple ID"
    echo "  2. Then run:  open ios/Runner.xcworkspace"
    echo "  3. Select Runner → Signing & Capabilities"
    echo "  4. Check 'Automatically manage signing'"
    echo "  5. Select your Team"
    echo "  6. Change Bundle Identifier to something unique"
    echo "     (e.g., com.yourname.wanderlust)"
    echo "  7. Re-run this script"
    echo ""
    exit 1
fi
echo -e "${GREEN}Found $IDENTITIES signing identity(ies).${NC}"

# Step 4: Install CocoaPods dependencies
echo ""
echo -e "${YELLOW}[3/5] Installing CocoaPods dependencies...${NC}"
flutter pub get
cd ios && pod install --repo-update 2>/dev/null || pod install
cd ..

# Step 5: Build
echo ""
echo -e "${YELLOW}[4/5] Building iOS app (debug)...${NC}"
flutter build ios --debug --no-codesign 2>/dev/null || true
# The actual signed build + install happens via flutter run

# Step 6: Install & launch on device
echo ""
echo -e "${YELLOW}[5/5] Installing on $DEVICE_NAME...${NC}"
flutter run -d "$DEVICE_ID" --release

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Done! App is running on $DEVICE_NAME  ${NC}"
echo -e "${GREEN}========================================${NC}"
