# README
A Terraform module repository to install Nginx ingress controller on my home lab Kubernetes cluster.

Useful Nginx ingress tuning and setup:
- <https://kubernetes.github.io/ingress-nginx/user-guide/tls/>
- <https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md>

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.19.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.nginx_ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_role_binding_v1.tailscale_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_v1.tailscale_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_secret_v1.tailscale_auth_key_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [template_file.nginx_values_with_tailscale](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_tailscale_tunnel"></a> [enable\_tailscale\_tunnel](#input\_enable\_tailscale\_tunnel) | Enable Tailscale tunnel on Nginx controller | `bool` | `false` | no |
| <a name="input_nginx_namespace"></a> [nginx\_namespace](#input\_nginx\_namespace) | The namespace to deploy Nginx. | `string` | `"nginx"` | no |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | The Tailscale auth key to join to the tailnet. | `string` | `null` | no |
<!-- END_TF_DOCS -->
