terraform {
  backend "gcs" {
    bucket         = "add-your-bucket-name" # Replace with your bucket name
    credentials    = "gcp-project-service-account-json-key.json" # Replace with the path to your GCP service account JSON key
    prefix         = "terraform/state/terrform-basic"             # Path to state file within the bucket
  }
}
