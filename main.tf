resource "kubernetes_namespace_v1" "nginx_namespace" {
  metadata {
    name = var.nginx_namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = kubernetes_namespace_v1.nginx_namespace.metadata.0.name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.4.0"
  create_namespace = true
  values           = [var.enable_tailscale_tunnel ? data.template_file.nginx_values_with_tailscale.rendered : file("${path.module}/files/values.yaml")]
  depends_on       = [kubernetes_role_binding_v1.tailscale_role_binding]
}
