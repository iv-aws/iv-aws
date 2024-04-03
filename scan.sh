#!/usr/bin/env bash

set -euo pipefail

printf 'Install SemGrep...\n'
python3 -m pip install semgrep --quiet

printf '[SEMGREP ○○○]\n'

# log in (enables Pro engine, connects findings to https://semgrep.dev/orgs/ivyfae_aws_personal_org/findings )

semgrep ci

printf '[SEMGREP ○○○] View findings at https://semgrep.dev/orgs/ivyfae_aws_personal_org/findings \n'