resource "google_compute_network" "minhavpc" {
  name                    = "minhavpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "minhasubnet" {
  name                     = "minhasubnet"
  ip_cidr_range            = var.subnet_ip
  network                  = google_compute_network.minhavpc.id
  region                   = var.region
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pods_ip
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.services_ip
  }
}