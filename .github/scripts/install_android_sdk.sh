#!/bin/bash

#ANDROID_HOME="/home/khammami/Android/Sdk"
cmdlineToolsPath="$ANDROID_HOME/cmdline-tools"

# Define package names and versions
BUILD_TOOLS="build-tools;34.0.0"
PLATFORM_TOOLS="platform-tools"

sudo chown $USER:$USER $ANDROID_HOME -R >/dev/null

#add paths for commandline-tools and platform-tools
export PATH="$cmdlineToolsPath/latest:$cmdlineToolsPath/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# set standard AVD path
export ANDROID_AVD_HOME="$HOME/.android/avd"

# accept all Android SDK licenses
echo "\yes" | sdkmanager --licenses

sdkmanager --update

#sdkmanager --install "cmdline-tools;latest" >/dev/null

# Check if packages are installed
if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "$BUILD_TOOLS"; then
  echo "Build tools $BUILD_TOOLS not found. Installing..."
  sdkmanager --install "$BUILD_TOOLS" 
else
  echo "Build tools $BUILD_TOOLS already installed."
fi

if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "$PLATFORM_TOOLS"; then
  echo "Platform tools not found. Installing..."
  sdkmanager --install "$PLATFORM_TOOLS" 
else
  echo "Platform tools already installed."
fi

# Check for emulator (more generic approach)
if ! sdkmanager --list | sed -e '/Available Packages/q' | grep -q "emulator"; then
  echo "Emulator not found. Installing..."
  sdkmanager --install emulator --channel=0
else
  echo "Emulator already installed."
fi

echo "Done checking and installing packages."
