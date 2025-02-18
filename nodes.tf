resource "google_container_node_pool" "moura-node-pool" {

  name     = var.node_name
  location = var.region
  cluster  = google_container_cluster.meu-cluster.name
  autoscaling {
    min_node_count  = 1
    max_node_count  = 3
    location_policy = "ANY"
  }

  node_config {
    preemptible  = true
    machine_type = var.tipo_maquina
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags         = [tolist(google_compute_firewall.meu-firewall.target_tags)[0]]
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }
}