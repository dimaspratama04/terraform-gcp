resource "google_compute_instance_template" "webserver_vm" {
  name         = "webserver-vm-template"
  machine_type = "e2-small"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    disk_size_gb = 20
    boot         = true
  }

  network_interface {
    network    = google_compute_network.network_dev.id
    subnetwork = google_compute_subnetwork.network_dev_subnet.id

    access_config {

    }
  }

  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y nginx-light jq

      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")

      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      </pre>
      EOF
    EOF1
  }

  tags = ["webserver"]
}

resource "google_compute_instance_group_manager" "mig" {
  name = "webserver-vm-mig"

  base_instance_name = "webserver" # webserver-qwe2
  zone               = "asia-southeast2-a"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.webserver_vm.id
    name              = "webserver"
  }

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_unavailable_fixed = 1
  }

}
