#!/usr/bin/env bash
# Install backend dependencies, handling camel-oasis Python 3.12+ restriction.
set -e

PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PY_MINOR=$(python3 -c "import sys; print(sys.version_info.minor)")

echo "Python $PY_VERSION detected"

pip install -r "$(dirname "$0")/../requirements.txt"

# camel-oasis wheel is pure-Python but its metadata gates on <3.12.
# Install without version resolver on Python 3.12+.
if [ "$PY_MINOR" -ge 12 ]; then
    echo "Python 3.12+: installing camel-oasis with --ignore-requires-python --no-deps"
    pip install --no-deps --ignore-requires-python camel-oasis==0.2.5
else
    pip install camel-oasis==0.2.5
fi

echo "All dependencies installed."
