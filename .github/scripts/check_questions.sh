#!/bin/bash

total_score=0

# Function to check and grade a single question
check_question() {
    local question_text="$1"
    local correct_answer_pattern="$2"
    local student_response="$3"
    local exit_on_fail="$4"

    # Pre-process student response to extract relevant lines
    student_q_response=$(grep -A 5 ".*$question_text" <<<"$student_response" | grep -i "\[X\]")

    # Init exit_on_fail to false
    if [[ -z "$exit_on_fail" ]]; then
        exit_on_fail=false
    fi

    # Check for empty response
    if [[ -z "$student_q_response" ]]; then
        echo "Question $question_text: Aucune réponse"
        score=0
        if [[ "$exit_on_fail" = true ]]; then
            exit 1
        else
            return
        fi
    fi

    # Count correctly checked answers using a more efficient method
    correct_count=$(grep -c "\\[X\] $correct_answer_pattern" <<<"$student_q_response")

    # Count all checked answers (including extras)
    checked_count=$(grep -c "\[X\]" <<<"$student_q_response")

    # Calculate score (1 for correct, -1 for extra)
    score=$((correct_count - (checked_count - correct_count)))
    score=$((score < 0 ? 0 : score)) # Ensure non-negative score

    echo "Question: $question_text"
    echo "Correct answer(s): $correct_answer_pattern"
    echo -e "Student response(s):\n$student_q_response"
    echo "Score: $score"
    echo ""

    if [[ "$exit_on_fail" = true ]] && [[ "$score" -eq 0 ]]; then
        exit 1
    fi

    total_score=$((total_score + score))
}

# Define questions and answers
# questions=(
#   "Quelles modifications sont apportées lorsque vous ajoutez une deuxième activité à votre application en choisissant"
#   "Que se passe-t-il si vous supprimez les éléments \`android:parentActivityName\` et \`<meta-data>\` de la deuxième déclaration d'activité du fichier \`AndroidManifest.xml\`\?"
# )

# answers=(
#   "La deuxième activité est ajoutée en tant que classe Java. Vous devez toujours ajouter le fichier de mise en page (layout) XML."
#   "Le deuxième fichier de mise en page (layout) XML d'activité est supprimé."
# )

IFS=$'\n'
readarray -t questions <.github/assets/questions.txt
readarray -t answers <.github/assets/answers.txt

nbQuestions=${#questions[@]}

# Read the student responses from the README.md file
student_responses=$(grep -A 5 ".* Choisissez-en un" "$README_PATH"/README.md)

if [ $# -eq 0 ]; then
    # Loop through each question and grade
    for i in "${!questions[@]}"; do
        check_question "${questions[$i]}" "${answers[$i]}" "$student_responses"
    done

    echo "==========================="
    echo "Total Score.........: $total_score"
    echo "Total Questions.....: ${nbQuestions}"
    echo "==========================="

    exit 0
elif [ $# -gt 2 ]; then
    echo "$0: Too many arguments: $*"
    exit 1
else
    if [ "$1" -eq 0 ]; then
        echo "Question number should start from 1"
        exit 1
    fi
    question_number=$1-1
    check_question "${questions[$question_number]}" "${answers[$question_number]}" "$student_responses" true
fi

# echo "rdme-score=${total_score}\n" >> $GITHUB_OUTPUT
# echo "var_name: rdme-score"
# echo "rdme-questions=${nbQuestions}\n" >> $GITHUB_OUTPUT
# echo "var-name: rdme-questions"

exit 0
