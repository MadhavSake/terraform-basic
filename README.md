
## Objective

Provision an AWS VPC in ap-south-1 using:

#Terraform
#GitHub Actions CI/CD
#OIDC authentication (no access keys)
#Remote state (S3 + DynamoDB)

AWS Account ID: <your-aws-account-project-id-required>
Repository: MadhavSake/terraform-basic
Branch: aws-basic
bucket : <bucket-name>



## Resources:

1 VPC
2 Public Subnets
2 Private Subnets
Internet Gateway
NAT Gateway
Route Tables
S3 (Terraform state)
DynamoDB (State locking)

## Prerequisites
AWS Account Access
IAM permissions to create:

IAM roles
OIDC provider
S3 bucket
DynamoDB table

GitHub repository
Terraform files already added

## Step 1 – Create OIDC Provider

aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1


  ## Verify:

  Expected: arn:aws:iam::<project-name>:oidc-provider/token.actions.githubusercontent.com


  ## Step 2 – Create IAM Role for GitHub

  # replace this <your-project-name> value your project name


  cat <<EOF > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<your-project-name>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:sub": "repo:MadhavSake/terraform-basic:ref:refs/heads/aws-basic",
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF



## Create role
aws iam create-role \
  --role-name GitHubActionsTerraformRole \
  --assume-role-policy-document file://trust-policy.json


## Attach permissions (initial testing) 
aws iam attach-role-policy \
  --role-name GitHubActionsTerraformRole \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

## Verify:
aws iam list-attached-role-policies \
  --role-name GitHubActionsTerraformRole

----------------------------------------------------------------------------------------------------------------------------------------------

## Step 3 – Create Remote Backend##

## Create S3 Bucket

aws s3api create-bucket \
  --bucket <bucket-name> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable Versioning

aws s3api put-bucket-versioning \
  --bucket <bucket-name> \
  --versioning-configuration Status=Enabled

## Enable Encryption

aws s3api put-bucket-encryption \
  --bucket <bucket-name> \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'

## Create DynamoDB Table

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1

## Verify:

aws dynamodb list-tables --region ap-south-1

## add this bucket name in backend.tf line 3

 bucket         = "<your-bucket-name>"

## File .github/workflows/terraform.yml Line number 26 update <your-project-name> 


role-to-assume: arn:aws:iam::<your-project-name>:role/GitHubActionsTerraformRole

--------------------------------------------------------------------------------------------------------------------------

## for destroy resources # comment out apply command and for apply # comment out destroy command in .github/workflows/terraform.yml

## Example for Destroy 

  #- name: Terraform Apply
        #if: github.ref == 'refs/heads/aws-basic'
        #run: terraform apply -auto-approve

      - name: Terraform Destroy
        if: github.ref == 'refs/heads/aws-basic'
        run: terraform destroy -auto-approve
