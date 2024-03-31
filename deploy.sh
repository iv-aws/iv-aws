set -euo pipefail

echo 'Begin Deploy Script'
echo 'Setting Variables'
export TF_VAR_COMMIT_TIMESTAMP=$(git log --format='%ct')
export TF_VAR_COMMIT_BRANCH=$(git branch --show-current) 

printf '\n'
echo 'Source Info'
printf '+-------------------------------------------------\n'
printf '|      Branch: %s\n' $TF_VAR_COMMIT_BRANCH
printf '| Commit Hash: %s\n' "$(git log --format='%h')"
printf '| Commit Date: %s\n' "$(git log --format='%cd')"
printf '|              %s\n' $TF_VAR_COMMIT_TIMESTAMP
printf '| \n'
printf '|      Author: %s\n' "$(git log --format='%an')"
printf '+-------------------------------------------------\n\n'

cd deploy/tf
    printf '\n* Terraform Validate:\n'
    terraform validate

    printf '\n* Terraform Plan:\n'
    terraform plan

    printf '\n* Terraform Apply:\n'
    terraform apply
cd -

echo '[+] Deploy Script Done!'