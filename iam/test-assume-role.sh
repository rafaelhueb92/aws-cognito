aws sts assume-role-with-web-identity \
  --role-arn arn:aws:iam::$1:role/GitHubActionsRole \
  --role-session-name TestSession 