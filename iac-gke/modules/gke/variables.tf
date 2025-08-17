variable "cluster_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "node_count" {
  type    = number
  default = 2
}
