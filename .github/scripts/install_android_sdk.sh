#!/bin/bash

#cmdlineToolsPath="$ANDROID_HOME/cmdline-tools"

# Define package names and versions
BUILD_TOOLS="build-tools;34.0.0"
PLATFORM_TOOLS="platform-tools"
SDKMANAGER_LIST_DELIM='/Available Packages/q'
TEST_IMG_PCKG="system-images;android-${IMG_API_LEVEL};google_apis;x86"

# echo "Grant permission for Android Home Sdk..."
# sudo chown $USER:$USER $ANDROID_HOME -R >/dev/null

#add paths for commandline-tools and platform-tools
#export PATH="$cmdlineToolsPath/latest:$cmdlineToolsPath/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# # set standard AVD path
# export ANDROID_AVD_HOME="$HOME/.android/avd"

# Accept licenses and update sdkmanager
echo "Accepting licenses and updating sdkmanager..."
bash -c "yes 'y' | sdkmanager --licenses" >/dev/null
sdkmanager --update >/dev/null

#sdkmanager --install "cmdline-tools;latest" >/dev/null

# Check if packages are installed
if ! sdkmanager --list | sed -e "$SDKMANAGER_LIST_DELIM" | grep -q "$BUILD_TOOLS"; then
  echo "Build tools $BUILD_TOOLS not found. Installing..."
  sdkmanager --install "$BUILD_TOOLS" >/dev/null
  echo "$BUILD_TOOLS has been installed successfully!"
else
  echo "Build tools $BUILD_TOOLS already installed."
fi

if ! sdkmanager --list | sed -e "$SDKMANAGER_LIST_DELIM" | grep -q "$PLATFORM_TOOLS"; then
  echo "Platform tools not found. Installing..."
  sdkmanager --install "$PLATFORM_TOOLS" >/dev/null
  echo "Platform tools has been installed successfully!"
else
  echo "Platform tools already installed."
fi

# Check for emulator (more generic approach)
if ! sdkmanager --list | sed -e "$SDKMANAGER_LIST_DELIM" | grep -q "emulator"; then
  echo "Emulator not found. Installing..."
  sdkmanager --install emulator --channel=0 >/dev/null
  echo "Emulator has been installed successfully!"
else
  echo "Emulator already installed."
fi

# Check for system image for the test
if ! sdkmanager --list | sed -e "$SDKMANAGER_LIST_DELIM" | grep -q "$TEST_IMG_PCKG"; then
  echo "System image not found. Installing..."
  sdkmanager --install "$TEST_IMG_PCKG" >/dev/null
  echo "System image has been installed successfully!"
else
  echo "System image already installed."
fi

echo "Done checking and installing packages."
