provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

# ------------------------------
# Enable Compute API
# ------------------------------
resource "google_project_service" "compute" {
  service  = "compute.googleapis.com"
  project  = var.project

  disable_on_destroy         = false
  disable_dependent_services = false
}

# ------------------------------
# Enable GKE API
# ------------------------------
resource "google_project_service" "container" {
  service  = "container.googleapis.com"
  project  = var.project

  disable_on_destroy = false
}

# ------------------------------
# Enable Cloud Resource Manager API
# (DO NOT disable this ever)
# ------------------------------
resource "google_project_service" "cloudresourcemanager" {
  service  = "cloudresourcemanager.googleapis.com"
  project  = var.project

  disable_on_destroy = false
}
