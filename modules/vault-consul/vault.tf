# https://github.com/hashicorp/vault-helm
# https://www.vaultproject.io/docs/platform/k8s/helm/examples/ha-with-consul

locals {
  vault_values = {
    "server.ha.enabled"  = true
    "server.ha.replicas" = 1 # Keep this higher for higher availabilty
  }
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  depends_on  = [helm.release.consul]
  name        = "vault"
  namespace   = kubernetes_namespace.vault.metadata.0.name
  respository = "https://helm.releases.hashicorp.com"
  chart       = "vault"
  version     = "1.9.2"

  dynamic "set" {
    for_each = local.vault_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
