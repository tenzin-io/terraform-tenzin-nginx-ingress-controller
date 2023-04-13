resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.nginx_namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.4.0"
  create_namespace = true
  values           = [var.enable_tailscale_tunnel ? data.template_file.nginx_values_with_tailscale.rendered : file("${path.module}/files/values.yaml")]
}
