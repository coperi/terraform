provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Build expression for countries. Example: ip.geoip.country in {"CN", "RU"}
locals {
  countries_expr = length(var.block_countries) > 0 ? "ip.geoip.country in {${join(", ", [for c in var.block_countries : "\"${c}\""])}}" : "false"
}

resource "cloudflare_filter" "block_countries_filter" {
  zone_id    = var.zone_id
  expression = local.countries_expr
  description = "${var.rule_name} - country filter"
}

resource "cloudflare_firewall_rule" "block_countries" {
  zone_id    = var.zone_id
  filter_id  = cloudflare_filter.block_countries_filter.id
  action     = var.mode
  description = var.rule_name
  priority   = 1000
}
