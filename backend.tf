resource "google_compute_backend_service" "webserver_vm_backend" {
  name                  = "webserver-vm-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  enable_cdn            = false
  health_checks         = [google_compute_health_check.http_hc.id]
  backend {
    group          = google_compute_instance_group_manager.mig.instance_group
    balancing_mode = "UTILIZATION"
  }

}

resource "google_compute_health_check" "http_hc" {
  name = "http-hc"

  http_health_check {
    port = 80
  }

}
