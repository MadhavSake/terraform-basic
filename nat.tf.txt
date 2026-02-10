resource "google_compute_router_nat" "nat" {
  name    = "nat-gateway"
  router  = google_compute_router.router.name
  region  = var.region
  
source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private_1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.private_2.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
   nat_ips = [google_compute_address.natstage.self_link]
}
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "natstage" {
  name         = "natstage"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_project_service.compute]
}

