# Terraform repository

This repository contains Terraform configuration. The `cloudflare/` subfolder holds Cloudflare-specific resources.

To push the whole `terraform` folder to GitHub (not just a subfolder), run:

```bash
# Make script executable once
chmod +x push_to_github.sh
# Push to your repo
./push_to_github.sh git@github.com:<owner>/<repo>.git main
```

Notes:
- The script will initialize a git repo if none exists and create an initial commit.
- Replace `<owner>/<repo>` with your GitHub repository path.
- The repo-level `.gitignore` ignores all sensitive tfvars and state files under any subfolder.
