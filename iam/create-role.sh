AWS_ACCOUNT_ID=$1
GITHUB_REPO=$2

echo "Creating the Trust Policy for the Github Repository $2 to deploy into the AWS account ID $1"

sed -e "s/AWS_ACCOUNT_ID/$AWS_ACCOUNT_ID/g" -e "s|GITHUB_REPO|$GITHUB_REPO|g" trust-policy.json > trust-policy-temp.json

echo "Creating the role"

aws iam create-role \
    --role-name GitHubActionsRole \
    --assume-role-policy-document file://trust-policy-temp.json \
    --no-cli-pager \
    --output json

echo "Putting the policy into the role"

aws iam put-role-policy --role-name GitHubActionsRole \
  --policy-name GitHubActionsPolicy \
  --policy-document file://permission-policy.json 
  --no-cli-pager \
  --output json

aws iam get-role --role-name GitHubActionsRole --query 'Role.Arn' --output text
