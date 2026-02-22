terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

############################################
# Enable Compute Engine API
############################################

resource "google_project_service" "compute" {
  project                    = var.project
  service                    = "compute.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = false
}

############################################
# Enable Kubernetes Engine API
############################################

resource "google_project_service" "container" {
  project            = var.project
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

############################################
# Enable Cloud Resource Manager API
############################################

resource "google_project_service" "cloudresourcemanager" {
  project            = var.project
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}
