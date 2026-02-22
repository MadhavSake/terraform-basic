############################################
# GKE Cluster (Without Default Node Pool)
############################################

resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke-cluster"
  location = var.zone
  project  = var.project

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.private_1.id

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false
  networking_mode     = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  depends_on = [
    google_project_service.container,
  ]
}

############################################
# Custom Node Pool (With Dedicated SA)
############################################

resource "google_container_node_pool" "test_node_pool" {
  name     = "test-node-pool"
  cluster  = google_container_cluster.primary.name
  location = var.zone
  project  = var.project

  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-medium"
    spot         = true

    service_account = google_service_account.gke_nodes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  depends_on = [
    google_service_account.gke_nodes,
  ]
}
