#!/bin/bash

# AVD_NAME & IMG_API_LEVEL are available in workflow env
echo no | avdmanager create avd --force -n "${AVD_NAME}" --abi 'google_apis/x86' --package "system-images;android-${IMG_API_LEVEL};google_apis;x86"