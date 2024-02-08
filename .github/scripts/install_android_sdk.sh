#!/bin/bash

#ANDROID_HOME="/home/khammami/Android/Sdk"
cmdlineToolsPath="$ANDROID_HOME/cmdline-tools"

# Define package names and versions
BUILD_TOOLS="build-tools;34.0.0"
PLATFORM_TOOLS="platform-tools"

# /usr/bin/sh -c \"sudo chown $USER:$USER $ANDROID_HOME -R

#add paths for commandline-tools and platform-tools
export PATH="$cmdlineToolsPath/latest:$cmdlineToolsPath/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# set standard AVD path
export ANDROID_AVD_HOME="$HOME/.android/avd"

# accept all Android SDK licenses
#/usr/bin/sh -c \\yes | sdkmanager --licenses >/dev/null

/usr/bin/sh -c  sdkmanager --update >/dev/null

/usr/bin/sh -c  sdkmanager --install "cmdline-tools;latest" >/dev/null

# Check if packages are installed
if ! sdkmanager --list | grep -q "$BUILD_TOOLS"; then
  echo "Build tools $BUILD_TOOLS not found. Installing..."
  /usr/bin/sh -c sdkmanager --install "$BUILD_TOOLS" >/dev/null
else
  echo "Build tools $BUILD_TOOLS already installed."
fi

if ! sdkmanager --list | grep -q "$PLATFORM_TOOLS"; then
  echo "Platform tools not found. Installing..."
  /usr/bin/sh -c sdkmanager --install "$PLATFORM_TOOLS" >/dev/null
else
  echo "Platform tools already installed."
fi

# Check for emulator (more generic approach)
if ! sdkmanager --list | grep -q "emulator"; then
  echo "Emulator not found. Installing..."
  /usr/bin/sh -c sdkmanager --install emulator --channel=0 >/dev/null
else
  echo "Emulator already installed."
fi

echo "Done checking and installing packages."
