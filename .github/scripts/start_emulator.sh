#!/bin/bash

# Set options
set -e # Exit script if any command fails

# Define variables (use clear names)
ANDROID_SDK_HOME="/usr/local/lib/android/sdk" # Adjust for your OS
AVD_NAME="test"
PLATFORM_IMAGE="system-images;android-${IMG_API_LEVEL};google_apis;x86"

# Helper functions
function start_emulator() {
    # Start emulator in background, redirecting output to log
    "$ANDROID_SDK_HOME"/emulator/emulator -avd "$AVD_NAME" \
        -no-snapshot-save -no-window -gpu swiftshader_indirect \
        -noaudio -no-boot-anim -camera-back none &>/tmp/log.txt &

    # Wait for boot completion and press home button
    "$ANDROID_SDK_HOME"/platform-tools/adb wait-for-device shell \
        'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'

    # Disable animations for faster tests
    "$ANDROID_SDK_HOME"/platform-tools/adb shell settings put global window_animation_scale 0.0
    "$ANDROID_SDK_HOME"/platform-tools/adb shell settings put global transition_animation_scale 0.0
    "$ANDROID_SDK_HOME"/platform-tools/adb shell settings put global animator_duration_scale 0.0

    # List connected devices
    "$ANDROID_SDK_HOME"/platform-tools/adb devices

    # Add ANDROID_SDK_ROOT for child process (consider the use of setenv.sh)
    echo sdk.dir="${ANDROID_HOME_SDK}" >>"$ANDROID_APP_PATH"/local.properties

    echo "Emulator '$AVD_NAME' started!"
}

function check_emulator() {
    # Check if emulator already exists
    local count

    count=$("$ANDROID_SDK_HOME"/emulator/emulator -list-avds | wc -l)

    if [[ "$count" -gt 0 ]]; then
        echo "Emulator '$AVD_NAME' already available"
        start_emulator
    else
        echo "Emulator '$AVD_NAME' not found. Installing..."
        install_emulator
        start_emulator
    fi
}

function install_emulator() {
    # Update SDK tools
    "$ANDROID_SDK_HOME"/cmdline-tools/latest/bin/sdkmanager --update

    # Install necessary components
    "$ANDROID_SDK_HOME"/cmdline-tools/latest/bin/sdkmanager --install "emulator"
    "$ANDROID_SDK_HOME"/cmdline-tools/latest/bin/sdkmanager --install "$PLATFORM_IMAGE"

    # List available AVDs for verification
    "$ANDROID_SDK_HOME"/emulator/emulator -list-avds
}

# Check or install emulator
check_emulator

# # Additional notes for users
# echo "Linux:"
# echo "  \$ANDROID_HOME: /usr/local/lib/android/sdk"
# echo "Mac:"
# echo "  \$ANDROID_HOME: /Users/runner/Library/Android/sdk"

#exit 0 # Indicate successful execution
