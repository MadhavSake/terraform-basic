terraform {
  backend "s3" {
    bucket         = "madhav-terraform-state-582802577279"
    key            = "aws-basic/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
