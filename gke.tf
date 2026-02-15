############################################
# Cheapest GKE Cluster (POC)
############################################

resource "google_container_cluster" "primary" {
  name     = var.gke_name
  location = var.zone
  project  = var.project

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.private_1.id

  remove_default_node_pool = false
  initial_node_count       = 1

  deletion_protection = false
  networking_mode     = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  node_config {
    machine_type = "e2-medium"
    spot         = true

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
