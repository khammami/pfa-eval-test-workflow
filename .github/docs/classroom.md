# classroom.yml Jobs

1. **check-android-project**
    * **Purpose:** Verify submitted code is a valid Android project.
    * **Steps:**
        * Check for `build.gradle` file in `ANDROID_APP_PATH`.
        * Identify if `app` module uses Kotlin or Java.
    * **Trigger:** Manual & on push (not by GitHub Classroom bot).

2. **build**
    * **Purpose:** Perform autograding of the Android project.
    * **Prerequisites:** Needs successful completion of `check-android-project`.
    * **Setup:**
        * Enable KVM virtualization for emulators.
        * Set up Java 17 environment for Gradle.
        * Cache Gradle operations for faster builds.
        * Save and restore AVD cache for quicker emulator boot.
        * Create an AVD if not cached (custom options used).
        * Install necessary Android SDK packages.
        * Grant execution permission to `gradlew` script.
        * Create a script to set environment variables.
    * **Testing:**
        * Start the emulator using a custom script (not provided).
        * Integrate with `education/autograding@v1` for test execution and reporting.
    * **Cleanup:** Stop the running emulator after tests.
    * **Trigger:** Manual and on push.

## Important Notes

* This workflow relies on external scripts in `.github/scripts` (not provided here).
* Some steps use secrets (like `ANSWERS_SECRET_PASSPHRASE`) defined in your repository settings.
* Basic knowledge of GitHub Actions and Android development is assumed.
