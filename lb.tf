resource "google_compute_global_address" "lb_ip" {
  name = "glb-static-ip-${random_string.str.result}"

}

resource "google_compute_global_forwarding_rule" "lb_rule" {
  name                  = "webserver-vm-lb-rule"
  target                = google_compute_target_http_proxy.lb_proxy.id
  ip_address            = google_compute_global_address.lb_ip.address
  port_range            = 80
  load_balancing_scheme = "EXTERNAL"
  network_tier          = "PREMIUM"
}

resource "google_compute_url_map" "lb_url" {
  name            = "webserver-vm-url-map"
  default_service = google_compute_backend_service.webserver_vm_backend.id

}

resource "google_compute_target_http_proxy" "lb_proxy" {
  name    = "webserver-vm-http-proxy"
  url_map = google_compute_url_map.lb_url.id

}
