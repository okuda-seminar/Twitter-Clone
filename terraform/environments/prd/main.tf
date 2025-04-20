module "s3" {
  source     = "../../modules/s3"
  env        = var.env
  account_id = var.account_id
}


module "cognito" {
  source = "../../modules/cognito"
  env                = var.env
  user_pool_name     = var.user_pool_name
  callback_urls      = var.callback_urls
  logout_urls        = var.logout_urls
}