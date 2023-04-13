#
# Nginx Ingress
#

variable "enable_tailscale_tunnel" {
  type        = bool
  description = "Enable Tailscale tunnel on Nginx controller"
  default     = false
}

variable "tailscale_auth_key" {
  type        = string
  description = "The Tailscale auth key to join to the tailnet."
  default     = null
}

variable "nginx_namespace" {
  type        = string
  default     = "nginx"
  description = "The namespace to deploy Nginx."
}
