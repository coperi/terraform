output "ruleset_id" {
  description = "ID of the Cloudflare ruleset created to block non-allowed countries"
  value       = cloudflare_ruleset.block_non_allowed_countries.id
}
