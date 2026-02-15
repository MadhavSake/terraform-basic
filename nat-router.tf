############################################
# Enable Compute API (if not already enabled)
############################################

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  project = var.project
}

############################################
# Static External IP for NAT
############################################

resource "google_compute_address" "natstage" {
  name         = "natstage"
  project      = var.project
  region       = var.region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [
    google_project_service.compute
  ]
}

############################################
# Cloud Router
############################################

resource "google_compute_router" "router" {
  name    = "vpc-router"
  region  = var.region
  network = google_compute_network.main.id
  project = var.project

  depends_on = [
    google_project_service.compute
  ]
}

############################################
# Cloud NAT
############################################

resource "google_compute_router_nat" "nat" {
  name   = var.nat_name
  router = google_compute_router.router.name
  region = var.region
  project = var.project

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  nat_ips = [
    google_compute_address.natstage.self_link
  ]

  # Private Subnet 1
  subnetwork {
    name                    = google_compute_subnetwork.private_1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  # Private Subnet 2
  subnetwork {
    name                    = google_compute_subnetwork.private_2.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  depends_on = [
    google_compute_router.router,
    google_compute_address.natstage
  ]
}
