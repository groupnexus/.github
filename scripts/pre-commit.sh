#!/bin/sh
files=$(git diff --cached --name-only --diff-filter=ACMR | grep -Ei "\.py$")


if [ ! -z "${files}" ]; then
    echo "Formatting modified python files using black before committing them ..."
    black --exclude venv $files
    isort $files
    git add .
    echo "Running pylint on modified python files before committing them ..."
    pylint-fail-under --fail_under 10 $files
fi
