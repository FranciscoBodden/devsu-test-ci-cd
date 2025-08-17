resource "google_compute_network" "vpc_network" {
  name = "gke-network-test"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet-test"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}