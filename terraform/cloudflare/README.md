# Terraform Cloudflare

This folder contains Terraform configuration to create a Cloudflare firewall rule that blocks traffic from configured countries.

Required secrets for CI (GitHub Actions):
- CLOUDFLARE_API_TOKEN — scoped token with Firewall edit permissions
- CLOUDFLARE_ZONE_ID — the zone ID for the site

Notes:
- `terraform.tfvars` is ignored by `.gitignore`. Do not commit secrets.
- You can provide variables via environment variables `TF_VAR_cloudflare_api_token` and `TF_VAR_zone_id` for automation.
