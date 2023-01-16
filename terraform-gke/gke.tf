# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.project_id}-subnet"
  region                   = var.region
  network                  = google_compute_network.vpc.name
  ip_cidr_range            = var.vpc_cidr
  private_ip_google_access = true
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name               = "${var.project_id}-gke"
  location           = var.region
  network            = google_compute_network.vpc.name
  subnetwork         = google_compute_subnetwork.subnet.name
  initial_node_count = var.gke_num_nodes
  enable_legacy_abac = true

  node_config {
    machine_type = var.gke_instance_type
  }
}