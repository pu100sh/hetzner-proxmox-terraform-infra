variable "versioning_enabled" {
  type    = bool
  default = true
}

locals {
  config_name      = "kickstart"
  environment_name = ""
  ecosystem_name   = "root"
  project_name     = "pve"
  tenant_name      = "own"
  region           = "us-east-1"
  resources_name   = "own"

  bucket_name          = "${local.project_name}-${local.config_name}"

whitelist = [ "116.202.236.72/32" ]

  # Tags
  common_tags = {
    "Config"      = local.config_name
    "Environment" = local.environment_name
    "Ecosystem"   = local.ecosystem_name
    "Project"     = local.project_name
    "Tenant"      = local.tenant_name
  }
}
