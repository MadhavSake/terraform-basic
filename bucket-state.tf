resource "google_storage_bucket" "terraform_state" {
  name                        = "state-bucket-name" # Replace with a globally unique name
  location                    = "asia-south1"              # Specify the bucket location (India region)
  storage_class               = "STANDARD"                 # Use "STANDARD", "NEARLINE", etc.
  uniform_bucket_level_access = true                       # Recommended for simpler access control

  versioning {
    enabled = true # Enable versioning for state file backup
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # Optional: Delete objects older than 30 days
    }
  }
}

output "bucket_name" {
  value = google_storage_bucket.terraform_state.name

}
