provider "google" {
  project     = "gcp-gke-459721"  # Use your actual GCP project ID
  region      = "us-central1"     # You can change this
  credentials = file("gcp-cred/gcp-gke-459721-783756b0659f.json")
}

resource "google_container_cluster" "primary" {
  name     = "multi-cloud-gke"
  location = "us-central1"        # Same as the region

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location

  node_count = 2

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
