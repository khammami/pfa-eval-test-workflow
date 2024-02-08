#!/bin/bash

cmdlineToolsPath="$ANDROID_HOME/cmdline-tools"

# Define package names and versions
BUILD_TOOLS="build-tools;34.0.0"
PLATFORM_TOOLS="platform-tools"

echo "Grant permission for Android Home Sdk..."
sudo chown $USER:$USER $ANDROID_HOME -R >/dev/null

#add paths for commandline-tools and platform-tools
export PATH="$cmdlineToolsPath/latest:$cmdlineToolsPath/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# set standard AVD path
export ANDROID_AVD_HOME="$HOME/.android/avd"

# accept all Android SDK licenses
echo "Accept all licenses..."
"y" | sdkmanager --licenses >/dev/null

# Update sdkmanager packages to the latest version
echo "Updates installed packages in sdkmanager..."
sdkmanager --update >/dev/null

#sdkmanager --install "cmdline-tools;latest" >/dev/null

# Check if packages are installed
if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "$BUILD_TOOLS"; then
  echo "Build tools $BUILD_TOOLS not found. Installing..."
  sdkmanager --install "$BUILD_TOOLS" >/dev/null
  echo "$BUILD_TOOLS has been installed successfully!"
else
  echo "Build tools $BUILD_TOOLS already installed."
fi

if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "$PLATFORM_TOOLS"; then
  echo "Platform tools not found. Installing..."
  sdkmanager --install "$PLATFORM_TOOLS" >/dev/null
  echo "Platform tools has been installed successfully!"
else
  echo "Platform tools already installed."
fi

# Check for emulator (more generic approach)
if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "emulator"; then
  echo "Emulator not found. Installing..."
  sdkmanager --install emulator --channel=0 >/dev/null
  echo "Emulator has been installed successfully!"
else
  echo "Emulator already installed."
fi

echo "Done checking and installing packages."