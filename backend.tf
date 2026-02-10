terraform {
  backend "gcs" {
    bucket         = "coversure-stage-state-bucket" # Replace with your bucket name
    prefix         = "terraform/state"             # Path to state file within the bucket
    credentials    = "coversure-infra-stage-terraform.json" # Replace with the path to your GCP service account JSON key
  }
}