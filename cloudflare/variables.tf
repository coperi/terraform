variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with `Zone:Read` and `Zone:Firewall:Edit` (or equivalent) permissions. Can also be provided via the CLOUDFLARE_API_TOKEN environment variable."
  default     = "Om9s1h_iWsAHNooG4oBxmiGuHWeWo8SUhEkQDh6B"
  sensitive   = true
}

variable "zone_id" {
  type        = string
  description = "The Cloudflare Zone ID (required)."
}

variable "allowed_countries" {
  type        = list(string)
  description = "List of allowed country codes (ISO 3166-1 alpha-2). Traffic from any other country will be blocked."
  default     = ["US", "CA", "MX"]
}
