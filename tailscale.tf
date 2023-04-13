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
    namespace = var.nginx_namespace
  }

  data = {
    ts_auth_key = var.tailscale_auth_key
  }

}

resource "kubernetes_role_v1" "tailscale_role" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role"
    namespace = var.nginx_namespace
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
  depends_on = [helm_release.nginx_ingress]
}

resource "kubernetes_role_binding_v1" "tailscale_role_binding" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role-binding"
    namespace = var.nginx_namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "tailscale-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "ingress-nginx"
    namespace = var.nginx_namespace
  }
  depends_on = [helm_release.nginx_ingress]
}
