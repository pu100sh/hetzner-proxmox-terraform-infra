module "s3_bucket" {
  source                                       = "git::ssh://git@github.com/pu100sh/hetzner-proxmox-terraform-modules.git//aws-s3?ref=0.1"
  bucket_name                                  = local.bucket_name
  versioning_enabled                           = var.versioning_enabled
  whitelist                                    = local.whitelist
  common_tags                                  = local.common_tags
}
