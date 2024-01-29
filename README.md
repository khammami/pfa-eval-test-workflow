# [PFA] Assessment of Student Android Projects

## Project Aim

To automate the assessment of Android projects submitted by students, saving instructors time and providing faster feedback to learners.

## Key Features

- **GitHub Classroom Integration:**

   Seamless assignment creation and student repository management.

- **GitHub Actions Workflow:**

   Automatic triggering of the evaluation process upon submission.

- **Comprehensive Testing:**

   Unit tests for code integrity, Android tests for app behavior, and automated evaluation for correctness and completeness.

- **Automated Feedback:**

   Timely delivery of evaluation results to students, fostering quicker learning and iteration.

## Workflow Breakdown

1. **Assignment Setup:**

   Instructors use GitHub Classroom to create and distribute Android assignments.

2. **Student Submission:**

   Students submit their projects to their designated repositories.

3. **GitHub Actions Activation:**

   Submission triggers the CI/CD pipeline.

4. **Project Build:**

   The pipeline assembles the Android project.

5. **Code Verification:**

   Unit tests scrutinize code quality and functionality.

6. **App Behavior Validation:**

   Android tests ensure the app performs as expected on devices or emulators.

7. **Automated Grading:**

   Custom scripts or testing frameworks grade the student's work.

8. **Feedback Loop:**

   Evaluation results, including detailed feedback, are automatically shared with the student.

## Getting Started

### Prerequisites

- Java
- Android Studio
- GitHub Classroom
- GitHub Actions

### Installation

Clone the repository using the provided command.

## Additional Insights

- Customizable Evaluation: The project likely allows instructors to tailor evaluation criteria and feedback mechanisms.
- Scalability: Supports multiple assignments and students concurrently.
- Potential Benefits:
  - Reduced instructor workload
  - Faster feedback for students
  - Consistent and unbiased grading
  - Encourages student engagement and active learning
  - Fosters best practices in Android development

## Citation

Please cite this work as:

> Hammami K & Ben Abdallah A (2024) pfa-eval-android-project: Scripts
> to automate the assessment of Android projects submitted by students.
> URL: <https://github.com/Enet-Com-23/pfa-eval-android-project>.
