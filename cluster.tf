resource "google_container_cluster" "meu-cluster" {
  name                     = var.cluster_name
  location                 = var.region
  node_locations           = data.google_compute_zones.available.names
  initial_node_count       = 1
  remove_default_node_pool = true
  network                  = google_compute_network.minhavpc.self_link
  subnetwork               = google_compute_subnetwork.minhasubnet.self_link

  deletion_protection = false

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ip
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.minhasubnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.minhasubnet.secondary_ip_range[1].range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "minha-rede"
    }
  }
}