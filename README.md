# EC2 Running Instanes for eu-west-1

This is a repo holds the config for a Lambda Function which runs via a 30 minutes schedule via a Rule in Eventbridge.

The Lambda pulls secrets from SSM Parameter Store which are encrypted via KMS in order to pull the Total Running EC2 instances from the source 
AWS account.  

In order to stand up the environment you need to run the following:

terraform apply -var="access_key=encrypted_with_gpg" -var="secret_access_key=encrypted_with_gpg"

Replace encrypted_with_gpg with secrets which you can decrypt providing you have a public key which has been trusted.  Secrets are stored in

terraform/secrets/source_aws_account.gpg.encrypted