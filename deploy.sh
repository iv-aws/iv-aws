set -euo pipefail

echo 'Begin Deploy Script'
echo 'Setting Variables'
export TF_VAR_COMMIT_HASH=$(git log -1 HEAD --format='%h')
export TF_VAR_COMMIT_TIMESTAMP=$(git log -1 HEAD --format='%ct')
export TF_VAR_COMMIT_BRANCH=$(git branch --show-current) 

year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
hour=$(date +%H)
minute=$(date +%M)
second=$(date +%S)
plan_dir="plans/$year/$month/$day"
plan_id="$hour-$minute-$second-$TF_VAR_COMMIT_BRANCH-$TF_VAR_COMMIT_HASH"

printf '\n'
echo 'Source Info'
printf '+-------------------------------------------------\n'
printf '|      Branch: %s\n' $TF_VAR_COMMIT_BRANCH
printf '| Commit Hash: %s\n' TF_VAR_COMMIT_HASH
printf '| Commit Date: %s\n' "$(git log -1 HEAD --format='%cd')"
printf '|              %s\n' $TF_VAR_COMMIT_TIMESTAMP
printf '| \n'
printf '|      Author: %s\n' "$(git log -1 HEAD --format='%an')"
printf '+-------------------------------------------------\n\n'

cd deploy/tf
    printf '\n[TERRAFORM] (%s)\n' $plan_id

    printf '\n* Terraform Validate:\n'
    terraform validate

    printf '\n* Terraform Plan:\n'
    mkdir -p $plan_dir
    terraform plan --var-file=terraform.tfvars -out="$plan_dir/$plan_id.tfplan"

    printf '\n* Terraform Apply:\n'
    echo "Applying $plan_dir/$plan_id.tfplan ..."
    # terraform apply "plans/tfplan"
cd -

echo '[+] Deploy Script Done!'