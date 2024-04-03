#!/usr/bin/env bash

set -euo pipefail

environment='local'
if [ $# -ne 0 ]; then
    environment=$1
fi

cd site
    printf '[ Installing Requirements ]'
    python3 -m pip install -r requirements.txt

    printf '[ Running Tests ]\n'

    printf 'Environment: %s\n' $environment

    echo '[#] API Tests'
        python3 -m unittest discover -s api

cd .. 

echo '[#] SemGrep'
if [ "$environment" != 'local' ]; then
    ./scan.sh
else
    echo "Skipping SemGrep (environment: $environment)"
fi