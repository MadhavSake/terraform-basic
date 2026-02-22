############################################
# GKE Node Service Account
############################################

resource "google_service_account" "gke_nodes" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
  project      = var.project
}

############################################
# IAM Roles for GKE Nodes
############################################

# Allow pulling images from Artifact Registry
resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Allow writing logs
resource "google_project_iam_member" "log_writer" {
  project = var.project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Allow monitoring metrics
resource "google_project_iam_member" "metric_writer" {
  project = var.project
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Allow pulling from GCR (if used)
resource "google_project_iam_member" "storage_object_viewer" {
  project = var.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}
