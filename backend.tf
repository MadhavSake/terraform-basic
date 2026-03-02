terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "aws-basic/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

