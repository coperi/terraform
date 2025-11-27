variable "cloudflare_api_token" {
  description = "Cloudflare API token with permissions to manage firewall rules"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare Zone ID for the site where the rule will be applied"
  type        = string
}

variable "block_countries" {
  description = "List of ISO 3166-1 alpha-2 country codes to block. Example: [\"CN\", \"RU\"]"
  type        = list(string)
  default     = []
}

variable "rule_name" {
  description = "Name for the firewall rule"
  type        = string
  default     = "block_countries_rule"
}

variable "mode" {
  description = "Action to take for matching traffic: `block`, `challenge`, or `js_challenge`"
  type        = string
  default     = "block"
}
