resource "google_compute_firewall" "meu-firewall" {
  name    = "meu-firewall"
  network = google_compute_network.minhavpc.name

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}