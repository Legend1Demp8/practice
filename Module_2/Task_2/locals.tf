locals {
  env      = "netology-develop"
  project  = "platform"

  vm_web_name = "${local.env}-${local.project}-web"
  vm_db_name  = "${local.env}-${local.project}-db"
}
