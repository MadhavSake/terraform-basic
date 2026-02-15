############################################
# Enable Required API
############################################

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  project = var.project
}

############################################
# Cheapest GKE Cluster (POC)
############################################

resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke-cluster"
  location = var.zone   # Zonal = cheaper
  project  = var.project

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.private_1.id

  # Only 1 node
  remove_default_node_pool = false
  initial_node_count       = 1

  deletion_protection = false
  networking_mode     = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  node_config {
    machine_type = "e2-micro"   # cheapest machine

    # Spot instance (very cheap)
    spot = true

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  depends_on = [
    google_project_service.container
  ]
}
