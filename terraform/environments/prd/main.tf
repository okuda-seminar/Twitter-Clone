module "s3" {
  source     = "../../modules/s3"
  env        = var.env
  account_id = var.account_id
}

module "vpc" {
  source = "../../modules/vpc"
  env    = var.env
}

module "ec2" {
  source    = "../../modules/ec2"
  env       = var.env
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}

module "cognito" {
  source         = "../../modules/cognito"
  env            = var.env
  user_pool_name = var.user_pool_name
  callback_urls  = var.callback_urls
  logout_urls    = var.logout_urls
}
