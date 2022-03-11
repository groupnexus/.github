#!/bin/bash

# Create virtual environment
if test -d "$(pwd)/venv";
    then
    echo "Virtual env - venv already exists"
    source venv/bin/activate
else
    echo "Creating virtual env"
    virtualenv --python=python3.7 venv
    source venv/bin/activate
fi

# Install requirements
REQUIREMENTS_DEV="$(pwd)/requirements_dev.txt"
REQUIREMENTS="$(pwd)/requirements.txt"

if test -f "$REQUIREMENTS_DEV";
    then
    echo "Installing dev requirements"
    pip install -r "$REQUIREMENTS_DEV"

elif test -f "$REQUIREMENTS";
    then
    echo "Installing requirements.txt"
    pip install -r "$REQUIREMENTS"
else
    echo "requirements and requirements_dev.txt not exists!"
fi

# Python packages for pylint to work
PRE_COMMIT_PATH="$(pwd)/.github/scripts/pre-commit.sh"
PRE_PUSH_PATH="$(pwd)/.github/scripts/pre-push.sh"


# Setting up pre commit hook
if test -f "$PRE_COMMIT_PATH";
    then
    chmod a+x "$PRE_COMMIT_PATH"
    ln -s "$PRE_COMMIT_PATH" .git/hooks/pre-commit

else
  echo "Setup incomplete : pre-commit.sh not present"
fi

# Setting up pre push hook
if test -f "$PRE_PUSH_PATH";
  then
  chmod a+x "$PRE_PUSH_PATH"
  ln -s "$PRE_PUSH_PATH" .git/hooks/pre-push

else
  echo "Setup incomplete : pre-push.sh not present"
fi
