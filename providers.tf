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

resource "google_project_service" "compute" {
  service                    = "compute.googleapis.com"
  project                    = var.project
  disable_dependent_services = true
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  project = var.project
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
  project = var.project
}
