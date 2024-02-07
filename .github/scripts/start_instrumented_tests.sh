#!/bin/sh

test_target="$1"

if [ -z "$test_target" ]; then
    test_target="app:connectedAndroidTest"
fi

./"$ANDROID_APP_PATH"/gradlew "$test_target" -p "$ANDROID_APP_PATH"
