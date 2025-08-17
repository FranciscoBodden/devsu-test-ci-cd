resource "google_container_cluster" "primary" {
  name                    = var.cluster_name
  location                = var.zone
  remove_default_node_pool = true
  initial_node_count      = 1
  network                 = var.network_id
  subnetwork              = var.subnet_id
  ip_allocation_policy    {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = var.node_count
}