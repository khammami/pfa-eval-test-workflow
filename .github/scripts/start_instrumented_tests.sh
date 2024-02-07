#!/bin/sh

if command -v printenv >/dev/null 2>&1; then
  printenv
fi

test_target="$1"

if [ -z "$test_target" ]; then
    test_target="app:connectedAndroidTest"
fi

./"$ANDROID_APP_PATH"/gradlew "$test_target" -p "$ANDROID_APP_PATH"
