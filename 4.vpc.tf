############################################
# VPC Network
############################################

resource "google_compute_network" "main" {
  name                            = var.vpc_name
  project                         = var.project
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

############################################
# Public Subnet 1
############################################

resource "google_compute_subnetwork" "public_1" {
  name                     = "public-subnet-1"
  ip_cidr_range            = "10.3.0.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = false
  project                  = var.project
}

############################################
# Public Subnet 2
############################################

resource "google_compute_subnetwork" "public_2" {
  name                     = "public-subnet-2"
  ip_cidr_range            = "10.3.16.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = false
  project                  = var.project
}

############################################
# Private Subnet 1 (Used by GKE)
############################################

resource "google_compute_subnetwork" "private_1" {
  name                     = "private-subnet-1"
  ip_cidr_range            = "10.3.32.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  project                  = var.project

  # Required for GKE VPC-native cluster
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.4.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.5.0.0/20"
  }
}

############################################
# Private Subnet 2
############################################

resource "google_compute_subnetwork" "private_2" {
  name                     = "private-subnet-2"
  ip_cidr_range            = "10.3.48.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  project                  = var.project
}
