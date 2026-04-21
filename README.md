# Basic Terraform Monorepo (Old Versions------------>new one)

This repository contains a simple multi-environment Terraform layout using **older pinned versions**.

## Environments
- `envs/dev`
- `envs/staging`
- `envs/prod`

## Modules
- `modules/ec2`
- `modules/s3`
- `modules/lambda`
- `modules/iam`
- `modules/vpc`
- `modules/security_group`
- `modules/rds`

## Version Pins (intentionally old)
- Terraform: `>= 0.14.0, < 1.0.0`
- AWS Provider: `~> 3.75`

> Note: These versions are old by design per request. Upgrade before production use.
