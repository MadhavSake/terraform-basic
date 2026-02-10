terraform {
  backend "gcs" {
    bucket         = "bucket-name" # Replace with your bucket name
    prefix         = "terraform/state"             # Path to state file within the bucket
    credentials    = "gcp-project-service-account.json" # Replace with the path to your GCP service account JSON key
  }
}
