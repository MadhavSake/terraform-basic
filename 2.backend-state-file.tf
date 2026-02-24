terraform {
  backend "gcs" {
    bucket = "terrafor-state-bucket-name"
    prefix = "terraform/state/cicd-with-gke"
  }
}

