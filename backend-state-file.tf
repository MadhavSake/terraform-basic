terraform {
  backend "gcs" {
    bucket         = "terrafor-state-automation-480006" # Replace with your bucket name
    credentials    = "gcp-project-service-account-json-key.json" # Replace with the path to your GCP service account JSON key
    prefix         = "terraform/state/terrform-basic"             # Path to state file within the bucket
  }
}

