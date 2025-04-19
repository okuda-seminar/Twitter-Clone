module "s3" {
  source     = "../../modules/s3"
  env        = var.env
  account_id = var.account_id
}
