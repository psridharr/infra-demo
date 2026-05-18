# Venmo Terraform Monorepo

A multi-environment AWS infrastructure project managed with Terraform. All environments share reusable modules for consistency.

## Structure

```
.
├── envs/
│   ├── dev/
│   ├── staging/
│   └── prod/
└── modules/
    ├── vpc/
    ├── security_group/
    ├── ec2/
    ├── rds/
    ├── s3/
    ├── iam/
    ├── lambda/
    └── sns/
```

## Environments

| Environment | State File | Description |
|-------------|------------|-------------|
| dev | `terraform-dev.tfstate` | Development — 3 EC2 instances, full stack |
| staging | `terraform-staging.tfstate` | Staging — mirrors prod for pre-release testing |
| prod | `terraform-prod.tfstate` | Production — single EC2, no SNS |

Each environment provisions: VPC, Security Group, EC2, S3, IAM, Lambda, RDS (and SNS in dev/staging).

## Modules

| Module | What it creates |
|--------|----------------|
| `vpc` | VPC with 2 public + 2 private subnets across 2 AZs |
| `security_group` | Security group attached to the VPC |
| `ec2` | EC2 instance in a public subnet |
| `rds` | RDS instance in private subnets |
| `s3` | S3 bucket |
| `iam` | IAM role for Lambda execution |
| `lambda` | Lambda function wired to IAM role |
| `sns` | SNS topic |

## Requirements

- Terraform `>= 0.14.0, < 1.0.0`
- AWS Provider `~> 3.75`
- AWS region: `us-east-1` (default, configurable via `aws_region` variable)

## Usage

```bash
cd envs/<environment>
terraform init
terraform plan
terraform apply
```

> **Note:** Version pins are intentionally old. Upgrade provider and Terraform versions before production use.
