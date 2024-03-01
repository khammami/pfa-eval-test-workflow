#!/bin/bash

# AVD_NAME & IMG_API_LEVEL are available in workflow env

avd_path="${ANDROID_AVD_HOME}/${AVD_NAME}.avd"

[ ! -f "$avd_path" ] && {
    echo "Creating AVD named '$AVD_NAME'"
    echo no | avdmanager create avd --force -n "${AVD_NAME}" --abi 'google_apis/x86' --package "system-images;android-${IMG_API_LEVEL};google_apis;x86"
}

cat >>"$avd_path/config.ini" <<EOF
hw.cpu.ncore=2
EOF

# Start emulator in background, redirecting output to log
emulator -avd "$AVD_NAME" \
    -no-window -gpu swiftshader_indirect -noaudio -no-boot-anim -camera-back none &

# Wait for boot completion and press home button
adb wait-for-device shell \
    'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'

echo "Emulator '$AVD_NAME' booted!"
