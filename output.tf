output "cluster_name" {
  description = "O nome do cluster criado"
  value       = google_container_cluster.meu-cluster.name
}

output "node_name" {
  description = "O nome do node pool criado"
  value       = google_container_node_pool.moura-node-pool.name
}

output "cluster_location" {
  description = "A localização do cluster criado"
  value       = google_container_cluster.meu-cluster.location
}

output "cluster_endpoint" {
  description = "O endpoint do cluster criado"
  value       = google_container_cluster.meu-cluster.endpoint
}

output "cluster_master_version" {
  description = "A versão do master do cluster criado"
  value       = google_container_cluster.meu-cluster.master_version
}

output "cluster_node_version" {
  description = "A versão dos nodes do cluster criado"
  value       = google_container_cluster.meu-cluster.node_version
}

output "cluster_node_id" {
  description = "O id do node pool criado"
  value       = google_container_node_pool.moura-node-pool.id
}