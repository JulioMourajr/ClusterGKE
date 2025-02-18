resource "google_compute_router" "minha-rota" {
  name    = "minha-rota"
  network = google_compute_network.minhavpc.id
  region  = var.region
}

resource "google_compute_router_nat" "minha-nat" {
  name                               = "minha-nat"
  router                             = google_compute_router.minha-rota.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  region                             = google_compute_router.minha-rota.region

  log_config {
    enable = true
    filter = "ALL"
  }
}