terraform {
  backend "gcs" {
    bucket = "terrafor-state-automation-480006"
    prefix = "terraform/state/cicd-with-gke"
  }
}
