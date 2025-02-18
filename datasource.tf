data "google_compute_zones" "available" {
  status = "UP"
}

output "zones" {
  value = data.google_compute_zones.available.names
}

