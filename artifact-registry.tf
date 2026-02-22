############################################
# Enable Artifact Registry API
############################################

resource "google_project_service" "artifactregistry" {
  project = var.project
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

############################################
# Artifact Registry Docker Repository
############################################

resource "google_artifact_registry_repository" "gke_repo" {
  project       = var.project
  location      = var.region
  repository_id = "gke-docker-repo"
  description   = "Docker repository for private GKE cluster"
  format        = "DOCKER"

  depends_on = [
    google_project_service.artifactregistry
  ]
}

############################################
# Allow GKE Node SA to Pull Images
############################################

resource "google_artifact_registry_repository_iam_member" "gke_nodes_pull" {
  project    = var.project
  location   = var.region
  repository = google_artifact_registry_repository.gke_repo.name
  role       = "roles/artifactregistry.reader"

  member = "serviceAccount:${google_service_account.gke_nodes.email}"
}
