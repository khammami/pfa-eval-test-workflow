#!/bin/bash

# List all connected devices
devices=$("$ANDROID_HOME"/platform-tools/adb devices | grep emulator-)

# Iterate over each device and kill it
for device in $devices; do
    # Extract the device ID
    device_id="${device% device}"

    # Kill the emulator
    "$ANDROID_HOME"/platform-tools/adb -s "$device_id" emu kill

    # Wait for the emulator to be offline
    while "$ANDROID_HOME"/platform-tools/adb -s "$device_id" get-state | grep -q device; do
        sleep 1
    done

    echo "Emulator $device_id killed successfully."
done
