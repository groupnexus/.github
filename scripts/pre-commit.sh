#!/bin/sh
files=$(git diff --cached --name-only --diff-filter=ACMR | grep -Ei "\.py$")

CONFIG_FILE_PATH="$(pwd)/.github/pyproject.toml"

if [ ! -z "${files}" ]; then
    echo "Formatting modified python files using black before committing them ..."
    black --config="$CONFIG_FILE_PATH" --exclude venv $files
    isort --settings-path="$CONFIG_FILE_PATH" $files
    git add .
    echo "Running pylint on modified python files before committing them ..."
    pylint --fail-under=10 --rcfile="$CONFIG_FILE_PATH" $files
fi
