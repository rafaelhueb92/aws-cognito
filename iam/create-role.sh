AWS_ACCOUNT_ID=$1
GITHUB_REPO=$2

THUMBPRINT=$(openssl s_client -servername token.actions.githubusercontent.com -showcerts -connect token.actions.githubusercontent.com:443 </dev/null 2>/dev/null | \
openssl x509 -fingerprint -noout -sha1 | awk -F'=' '{print tolower($2)}' | tr -d ':')

echo "GitHub OIDC Thumbprint: $THUMBPRINT"

echo "Create the OIDC Provider"

aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list $THUMBPRINT

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
  --policy-document file://permission-policy.json \
  --no-cli-pager \
  --output json

aws iam get-role --role-name GitHubActionsRole --query 'Role.Arn' --output text
