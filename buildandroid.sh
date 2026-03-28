#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Wanderlust AI — Android Build & Install ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""

# Step 1: Check Flutter
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Error: Flutter not found in PATH.${NC}"
    exit 1
fi

# Step 2: Check for connected Android device
echo -e "${YELLOW}[1/4] Checking for connected Android device...${NC}"
ANDROID_DEVICE=$(flutter devices 2>/dev/null | grep -i "android" | head -1)

if [ -z "$ANDROID_DEVICE" ]; then
    echo -e "${RED}No Android device found.${NC}"
    echo ""
    echo "Make sure:"
    echo "  1. Device is connected via USB"
    echo "  2. USB debugging is enabled (Settings → Developer Options)"
    echo "  3. You've accepted the 'Allow USB debugging' prompt on device"
    echo "  4. Run: flutter devices"
    echo ""
    exit 1
fi

DEVICE_ID=$(echo "$ANDROID_DEVICE" | awk -F'•' '{print $2}' | xargs)
DEVICE_NAME=$(echo "$ANDROID_DEVICE" | awk -F'•' '{print $1}' | xargs)
echo -e "${GREEN}Found: $DEVICE_NAME ($DEVICE_ID)${NC}"

# Step 3: Get dependencies
echo ""
echo -e "${YELLOW}[2/4] Getting dependencies...${NC}"
flutter pub get

# Step 4: Build APK
echo ""
echo -e "${YELLOW}[3/4] Building APK...${NC}"
flutter build apk --debug

APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"

if [ ! -f "$APK_PATH" ]; then
    echo -e "${RED}Build failed — APK not found at $APK_PATH${NC}"
    exit 1
fi

echo -e "${GREEN}APK built: $APK_PATH${NC}"

# Step 5: Install on device
echo ""
echo -e "${YELLOW}[4/4] Installing on $DEVICE_NAME...${NC}"
adb -s "$DEVICE_ID" install -r "$APK_PATH"

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Done! App installed on $DEVICE_NAME    ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "Launch 'wanderlust' from your app drawer."
