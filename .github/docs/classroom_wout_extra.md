# Github Classroom Workflow (without reactivecircus)

## Overview

This workflow automates Android app grading within the Github Classroom environment, simulating manual testing using an emulator and leveraging autograding tools.

## Features

* **Android Project Check:** Validates the presence and language (Kotlin or Java) of an Android project within the `sample/application` folder.
* **Autograding:**
  * Enables KVM for emulator virtualization.
  * Sets up environment variables and paths required for Android development.
  * Caches AVDs for faster boot times.
  * Installs necessary Android SDK packages.
  * Creates or retrieves a cached AVD for testing.
  * Starts the emulator.
  * Injects environment variables for autograding tools.
  * Executes autograding using the `education/autograding` action.
  * Terminates the running emulator.

## Key Components

* **check-android-project job:** Ensures the repository contains a valid Android project before proceeding.
* **build job:** Handles various setup tasks and executes autograding:
  * `install_android_sdk.sh`: Installs required SDK packages.
  * `create_avd.sh`: Creates or retrieves an AVD.
  * `start_emulator.sh`: Starts the emulator.
  * `setenv.sh`: Sets environment variables for autograding.
  * `education/autograding`: Performs autograding logic specific to your setup.
  * `stop_emulators.sh`: Kills the running emulator after testing.

## Prerequisites

* Github repository containing your Android project.
* Github Actions enabled for your repository.
* Necessary autograding tools configured and integrated within the `education/autograding` action.

## Running the Workflow

1. **Manually:** Trigger the workflow manually through the Github Actions interface.
2. **Integration:** Integrate the workflow into your project's development process by linking it to specific events, such as pushes to the main branch.

## Customization

You can customize the workflow by modifying the following elements:

* `ANDROID_APP_PATH`: Path to your Android project's application folder.
* `README_PATH`: Path to your project's README file.
* `IMG_API_LEVEL`: Android API level for the AVD.
* `AVD_NAME`: Name of the AVD to use for testing.
* `install_android_sdk.sh`: Script to install specific SDK packages.
* `create_avd.sh`: Script to create or retrieve an AVD.
* `start_emulator.sh`: Script to start the emulator.
* `setenv.sh`: Script to set environment variables for autograding.
* `education/autograding`: Configuration of the autograding logic.

> [!important]
>
> Set an `ANSWERS_SECRET_PASSPHRASE`: Make sure you have a secret named `ANSWERS_SECRET_PASSPHRASE` defined in either your repository's secrets or your organization's secrets. This passphrase must match the one used to encrypt answers.txt.

## Troubleshooting

* Refer to the documentation for the `education/autograding` action for specific troubleshooting steps.
* Check the workflow logs for detailed error messages.

## Additional Notes

* This workflow serves as a general guideline and might require adjustments based on your specific autograding and project setup.
* Consider sharing or collaborating with others to benefit from community efforts and improve the workflow over time.
