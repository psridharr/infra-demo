terraform {
  backend "local" {
    path = "terraform-prod.tfstate"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix = "prod"
}

module "security_group" {
  source = "../../modules/security_group"

  name_prefix = "prod"
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  name_prefix        = "prod"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.sg_id]
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = "prod-example-tf-basic-bucket"
}

module "iam" {
  source = "../../modules/iam"

  name_prefix = "prod"
}

module "lambda" {
  source = "../../modules/lambda"

  function_name = "prod-basic-lambda"
  role_arn      = module.iam.lambda_role_arn
}

module "rds" {
  source = "../../modules/rds"

  name_prefix = "prod"
  subnet_ids  = module.vpc.private_subnet_ids
  vpc_id      = module.vpc.vpc_id
}
