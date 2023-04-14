#
# Nginx Ingress
#

locals {
  tailscale_auth_key_secret_name = "tailscale-auth-key-secret"
  tailscale_state_secret_name    = "tailscale-state-secret"
}

resource "kubernetes_secret_v1" "tailscale_auth_key_secret" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = local.tailscale_auth_key_secret_name
    namespace = kubernetes_namespace_v1.nginx_namespace.metadata.0.name
  }

  data = {
    ts_auth_key = var.tailscale_auth_key
  }
}

resource "kubernetes_role_v1" "tailscale_role" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role"
    namespace = kubernetes_namespace_v1.nginx_namespace.metadata.0.name
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = [local.tailscale_auth_key_secret_name, local.tailscale_state_secret_name]
    verbs          = ["get", "update", "patch"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
}

resource "kubernetes_role_binding_v1" "tailscale_role_binding" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role-binding"
    namespace = kubernetes_namespace_v1.nginx_namespace.metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.tailscale_role.0.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx"
    namespace = kubernetes_namespace_v1.nginx_namespace.metadata.0.name
  }
}
