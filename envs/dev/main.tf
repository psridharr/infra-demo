terraform {
  backend "local" {
    path = "terraform-dev.tfstate"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix = "dev"
}

module "security_group" {
  source = "../../modules/security_group"

  name_prefix = "dev"
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  name_prefix        = "dev"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.sg_id]
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = "dev-example-tf-basic-bucket"
}

module "s3_data" {
  source = "../../modules/s3"

  bucket_name        = "dev-venmo-data-bucket"
  versioning_enabled = true
  enable_lifecycle   = true
  sse_algorithm      = "AES256"

  lifecycle_rules = [
    {
      id      = "transition-to-ia"
      enabled = true
      prefix  = ""

      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        },
        {
          days          = 180
          storage_class = "DEEP_ARCHIVE"
        }
      ]

      expiration_days = 365

      noncurrent_version_transitions = [
        {
          days          = 30
          storage_class = "GLACIER"
        }
      ]

      noncurrent_version_expiration_days = 90
    },
    {
      id      = "expire-incomplete-multipart"
      enabled = true
      prefix  = ""

      transitions                        = []
      expiration_days                    = 0
      noncurrent_version_transitions     = []
      noncurrent_version_expiration_days = 0
    }
  ]

  tags = {
    Environment = "dev"
    Team        = "platform"
    ManagedBy   = "terraform"
  }
}

module "iam" {
  source = "../../modules/iam"

  name_prefix    = "dev"
  s3_bucket_arns = [module.s3_data.bucket_arn]
}

module "lambda" {
  source = "../../modules/lambda"

  function_name = "dev-basic-lambda"
  role_arn      = module.iam.lambda_role_arn
}

module "rds" {
  source = "../../modules/rds"

  name_prefix = "dev"
  subnet_ids  = module.vpc.private_subnet_ids
  vpc_id      = module.vpc.vpc_id
}
