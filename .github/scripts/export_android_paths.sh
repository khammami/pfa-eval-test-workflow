#!/bin/bash

# ANDROID_HOME is available in VM env
# LINUX:
# $ANDROID_HOME: /usr/local/lib/android/sdk
# MAC:
# $ANDROID_HOME: /Users/runner/Library/Android/sdk

# export ANDROID_HOME=/path/to/android/sdk
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH
# set standard AVD path
export ANDROID_AVD_HOME="$HOME/.android/avd"