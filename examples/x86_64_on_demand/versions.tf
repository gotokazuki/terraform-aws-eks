terraform {
  required_version = ">= 1.9"

  required_providers {
    aws        = "~> 5.0"
    kubernetes = "~> 2.0"
    helm       = "~> 2.0"
    tls        = "~> 4.0"
  }
}
