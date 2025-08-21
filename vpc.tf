resource "google_compute_network" "network_dev" {
  name                    = "network-development"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "network_dev_subnet" {
  name          = "network-developemnt-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-southeast2"
  network       = google_compute_network.network_dev.id

  secondary_ip_range {
    range_name    = "network-development-range"
    ip_cidr_range = "192.168.10.0/24"
  }
}
