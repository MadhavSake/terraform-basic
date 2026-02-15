############################################
# Enable Required API
############################################

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  project = var.project
}

############################################
# GKE Cluster
############################################

resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke-cluster"
  location = var.region
  project  = var.project

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.private_1.id

  # Keep default node pool
  remove_default_node_pool = false
  initial_node_count       = 1

  deletion_protection = false

  # VPC Native (Required for secondary ranges)
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  # Recommended settings
  networking_mode = "VPC_NATIVE"

  depends_on = [
    google_project_service.container
  ]
}

############################################
# Additional Node Pool
############################################

resource "google_container_node_pool" "gke_node_pool" {
  name     = "gke-node-pool"
  location = var.region
  cluster  = google_container_cluster.primary.name
  project  = var.project

  node_count = 2

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      env = "dev"
    }

    tags = ["gke-node"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
