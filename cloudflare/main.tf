terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  allowed_countries_list = join(" ", [for c in var.allowed_countries : "\"${c}\""])
  allowed_countries_expr = "ip.geoip.country in {${local.allowed_countries_list}}"
  block_expr             = "not (${local.allowed_countries_expr})"
}

resource "cloudflare_ruleset" "block_non_allowed_countries" {
  zone_id     = var.zone_id
  name        = "Block non-allowed countries"
  description = "Block traffic from all countries except US, CA, and MX"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [
    {
      description = "Block requests from countries not in allowed list (US, CA, MX)"
      expression  = local.block_expr
      action      = "block"
      ref         = "block_non_allowed_countries"
    }
  ]
}

