#!/bin/bash

# Set options
set -e          # Exit on error

# Helper functions
function start_emulator() {
    # Start avd
    emulator -avd "$AVD_NAME" \
        -no-snapshot-save -no-window -gpu swiftshader_indirect \
        -noaudio -no-boot-anim -camera-back none &>/tmp/log.txt &

    # Wait for boot completion and press home button
    adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'

    # Disable animations for faster tests
    adb shell settings put global window_animation_scale 0.0
    adb shell settings put global transition_animation_scale 0.0
    adb shell settings put global animator_duration_scale 0.0

    # List connected devices
    adb devices

    # Add ANDROID_SDK_ROOT for child process (consider setenv.sh)
    echo "sdk.dir=${ANDROID_HOME}" >>"$ANDROID_APP_PATH"/local.properties

    echo "Emulator '$AVD_NAME' started!"
}

function check_emulator() {
    # Check if $AVD_NAME exists in list of available AVDs
    local avds
    avds=$(emulator -list-avds | grep -w "$AVD_NAME")

    if [[ -n "$avds" ]]; then
        echo "Emulator '$AVD_NAME' already available"
        start_emulator
    else
        echo "Emulator '$AVD_NAME' not found."
        Exit 0
    fi
}

# Check and start emulator
check_emulator

# # Additional notes for users
# echo "Linux:"
# echo "  \$ANDROID_HOME: /usr/local/lib/android/sdk"
# echo "Mac:"
# echo "  \$ANDROID_HOME: /Users/runner/Library/Android/sdk"

#exit 0 # Indicate successful execution
