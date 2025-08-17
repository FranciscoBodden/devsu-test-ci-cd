provider "google" {
  project = var.project_id
  region  = substr(var.zone, 0, length(var.zone) - 2) # convierte "us-central1-a" → "us-central1"
  zone    = var.zone
  credentials = file("/tu/path/archivo.json")
  
}

resource "google_compute_network" "vpc_network" {
  name = "gke-network"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = substr(var.zone, 0, length(var.zone) - 2)
  network       = google_compute_network.vpc_network.id
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.zone
  remove_default_node_pool = true
  initial_node_count = 1
  network            = google_compute_network.vpc_network.id
  subnetwork         = google_compute_subnetwork.subnet.id
  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone

  node_config {
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 2
}
