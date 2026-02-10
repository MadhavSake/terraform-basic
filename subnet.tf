resource "google_compute_subnetwork" "public_1" {
  name                     = "public-subnet-1"
  ip_cidr_range            = "10.3.0.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = false
  project                  = var.project
}

resource "google_compute_subnetwork" "public_2" {
  name                     = "public-subnet-2"
  ip_cidr_range            = "10.3.16.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = false
  project                  = var.project
}

resource "google_compute_subnetwork" "private_1" {
  name                     = "private-subnet-1"
  ip_cidr_range            = "10.3.32.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.project
}

resource "google_compute_subnetwork" "private_2" {
  name                     = "private-subnet-2"
  ip_cidr_range            = "10.3.48.0/20"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.project

}
