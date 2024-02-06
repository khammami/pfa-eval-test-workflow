#!/bin/bash

# fail if any commands fails
set -e
# debug log
# set -x
# VARIABLES
API_LEVEL=29
#ANDROID_HOME_SDK="/usr/local/lib/android/sdk"
ANDROID_HOME_SDK="/home/khammami/Android/Sdk"

# Check Emulator already Installed
EMULATOR_COUNT=$($ANDROID_HOME_SDK/tools/emulator -list-avds | wc -l)

if [[ "$EMULATOR_COUNT" -gt 0 ]]; then 
    echo "Emulator already available"
else
    # Install Emulator
    $ANDROID_HOME_SDK/tools/bin/sdkmanager --update
    $ANDROID_HOME_SDK/tools/bin/sdkmanager --install "emulator"
    $ANDROID_HOME_SDK/tools/bin/sdkmanager --install "system-images;android-${API_LEVEL};google_apis;x86"
    # #echo "no" | ${ANDROID_HOME_SDK}/tools/bin/avdmanager --verbose create avd --force --name "pixel" --device "pixel" --package "system-images;android-${API_LEVEL};google_apis;x86" --tag "google_apis" --abi "x86"
    # $ANDROID_HOME_SDK/emulator/emulator @avd-test -no-window -no-boot-anim -netdelay none -no-snapshot -wipe-data -verbose -show-kernel -no-audio -gpu swiftshader_indirect -no-snapshot &> /tmp/log.txt &
    # adb wait-for-device shell "while [[ -z $(getprop sys.boot_completed) ]]; do sleep 5; done; input keyevent 82"
    # adb shell settings put global window_animation_scale 0.0
    # adb shell settings put global transition_animation_scale 0.0
    # adb shell settings put global animator_duration_scale 0.0
    # # Add ANDROID_SDK_ROOT
    # #echo sdk.dir=${ANDROID_HOME_SDK} >> sample/application/local.properties
fi


# LINUX:
# $ANDROID_HOME: /usr/local/lib/android/sdk
# MAC:
# $ANDROID_HOME: /Users/runner/Library/Android/sdk