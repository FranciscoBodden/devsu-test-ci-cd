provider "google" {
  project     = var.project_id
  region      = substr(var.zone, 0, length(var.zone) - 2)
  zone        = var.zone
  credentials = file(var.credentials_file)
}

module "network" {
  source = "./modules/network"
  region = substr(var.zone, 0, length(var.zone) - 2)
}

module "gke" {
  source      = "./modules/gke"
  cluster_name = var.cluster_name
  zone         = var.zone
  network_id   = module.network.network_id
  subnet_id    = module.network.subnet_id
  machine_type = "e2-small"
  node_count   = 2
}