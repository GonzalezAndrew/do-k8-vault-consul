locals {
  # Keep these two values higher or default to 3, it is a daemon set (value should be <= number of nodes available)
  consul_values = {
    "server.replicas"        = 1
    "server.bootstrapExpect" = 1
  }
}

resource "random_id" "gossip_key" {
  byte_length = 32
}

resource "kubernetes_secret" "gossip_key" {
  metadata {
    namespace = kubernetes_namespace.vault.metadata.0.name
    name      = "gossip-key"
  }

  data = {
    "gossip.key" = random_id.gossip_key.value
  }

  type = "Opaque"
}

resource "helm_release" "consul" {
  depends_on = [
    kubernetes_secret.gossip_key
  ]
  name        = "vault-backend"
  namespace   = kubernetes_namespace.vault.metadata.0.name
  respository = "https://helm.releases.hashicorp.com"
  chart       = "consul"
  version     = "1.11.1"

  dynamic "set" {
    for_each = local.consul_vaules
    content {
      name  = set.key
      value = set.value
    }
  }
}
