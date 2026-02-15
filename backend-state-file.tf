terraform {
  backend "gcs" {
    bucket         = "terrafor-state-automation-480006" # Replace with your bucket name
    prefix         = "terraform/state"             # Path to state file within the bucket
  }
}
