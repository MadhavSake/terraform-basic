//registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "firewall-allow-ssh" {
  name    = "var.firewall_name"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  priority      = 65534
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "firewall-allow-tcp" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "firewall-allow-tcp"
  network       = google_compute_network.main.name
  priority      = 1000
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]

}
