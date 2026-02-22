// Allow SSH (Ingress)
resource "google_compute_firewall" "firewall_allow_ssh" {
  name    = "allow-ssh-firewall"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  priority      = 65534
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
}


// Allow HTTP (Ingress)
resource "google_compute_firewall" "firewall_allow_http" {
  name    = "allow-tcp-firewall"
  network = google_compute_network.main.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}


// ✅ NEW: Allow Internet Egress (Required for GKE + NAT)
resource "google_compute_firewall" "firewall_allow_egress_internet" {
  name    = "allow-egress-internet"
  network = google_compute_network.main.name
  project = var.project

  direction          = "EGRESS"
  priority           = 1000
  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }
}

