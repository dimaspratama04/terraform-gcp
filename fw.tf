resource "google_compute_firewall" "fw_network_dev" {
  name    = "fw-network-development"
  network = google_compute_network.network_dev.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]

}
