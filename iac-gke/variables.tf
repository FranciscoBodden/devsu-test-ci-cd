variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "zone" {
  description = "Zona para GKE"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Nombre del cluster para GKE"
  type        = string
  default     = "gke-cluster"
}