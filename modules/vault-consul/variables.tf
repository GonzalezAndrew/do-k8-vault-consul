variable "cluster_name" {
  description = "A name for the Kubernetes cluster."
  type        = string
}

variable "cluster_id" {
  description = "A unique ID that can be used to identify and reference a Kubernetes cluster."
  type        = string
}

variable "host" {
  description = "The base URL of the API server on the Kubernetes master node."
  type        = string
}

variable "token" {
  description = "The DigitalOcean API access token used by clients to access the cluster."
}

variable "cluster_ca_certificate" {
  description = "The base64 encoded public certificate for the cluster's certificate authority."
}
