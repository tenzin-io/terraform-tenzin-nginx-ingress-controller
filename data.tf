data "template_file" "nginx_values_with_tailscale" {
  template = file("${path.module}/files/values-with-tailscale.yaml")
  vars = {
    tailscale_auth_key_secret_name = local.tailscale_auth_key_secret_name
    tailscale_state_secret_name    = local.tailscale_state_secret_name
  }
}

data "template_file" "nginx_values_without_tailscale" {
  template = file("${path.module}/files/values-without-tailscale.yaml")
  vars = {
    nginx_service_type = var.nginx_service_type
    enable_host_port   = var.nginx_service_type == "NodePort" ? true : false
  }
}
