# Cloudflare Terraform: Block all countries except US, CA, MX

This Terraform configuration creates a Cloudflare WAF ruleset that blocks requests from any country not in the allowed list. By default, only **US**, **CA** (Canada), and **MX** (Mexico) are allowed.

## Quick Start

### 1. Set your Cloudflare API token
Recommended scopes: `Zone:Read`, `Zone:Firewall:Edit`

```powershell
$env:CLOUDFLARE_API_TOKEN = "your_api_token_here"
```

### 2. Update `terraform.tfvars`
Set your Cloudflare zone ID and customize the allowed countries list:

```hcl
zone_id            = "your_zone_id_here"
allowed_countries  = ["US", "CA", "MX"]
```

### 3. Deploy
```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Configuration

All configuration is controlled via `terraform.tfvars`:

- **`zone_id`** *(required)* – Your Cloudflare zone ID (find in Dashboard > Zone Details)
- **`allowed_countries`** *(optional)* – List of ISO 3166-1 alpha-2 country codes to allow (default: `["US", "CA", "MX"]`)

## Notes

- The API token must have permissions to create/modify firewall rules in your zone.
- All countries except those listed in `allowed_countries` will be blocked.
- The ruleset is created in the zone-level firewall managed phase.
