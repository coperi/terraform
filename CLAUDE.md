# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository layout

This git repo (`~/projects`, remote `coperi/terraform`, default branch `main`) holds Terraform config under `terraform/`. The only module is `terraform/cloudflare/`, which creates a Cloudflare firewall rule that blocks, challenges or JS-challenges traffic from a list of countries. Resources are `cloudflare_filter` (expression built in `locals` from `block_countries`) and `cloudflare_firewall_rule` (priority 1000, action from `var.mode`).

`jev/` is a separate nested git repo (`coperi/jev`), untracked here. Don't `git add` it from this repo.

`terraform/push_to_github.sh` is an empty placeholder, although `terraform/README.md` describes it as a push script.

## Commands

Run from `terraform/cloudflare/`. CI pins Terraform 1.5.7 and the provider is `cloudflare/cloudflare ~> 4.0`.

```bash
terraform fmt -check -recursive   # CI gate; run `terraform fmt -recursive` to fix
terraform init -input=false
terraform validate
terraform plan -input=false
```

There are no tests. CI (`.github/workflows/terraform.yml`) runs fmt, init, validate and plan on push and PR to `main`.

## Secrets and variables

- Variables `cloudflare_api_token` (sensitive) and `zone_id` are required. Supply them via `TF_VAR_cloudflare_api_token` and `TF_VAR_zone_id`, or via a local `terraform.tfvars`.
- A local `terraform/cloudflare/terraform.tfvars` exists and is gitignored. Don't read, print or commit it.
- CI reads the repo secrets `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ZONE_ID`. The plan step fails until they are set.
- State is local and gitignored. No remote backend is configured, so CI plans run with no prior state.

## Gotchas

- `required_providers` lives in `providers.tf`, not `versions.tf`. Keep it there to avoid duplicate-declaration errors.
- The CI workflow must stay in the repo-root `.github/workflows/`. GitHub ignores workflows nested in subfolders.
- On disk the folder is `terraform/`, and git paths are lowercase too. Use lowercase paths in commands and scripts.
- `cloudflare_filter` and `cloudflare_firewall_rule` are deprecated in newer provider versions. Don't bump past `~> 4.0` without migrating.
