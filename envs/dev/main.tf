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

module "iam" {
  source = "../../modules/iam"

  name_prefix = "dev"
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
