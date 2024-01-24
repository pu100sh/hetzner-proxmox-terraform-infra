module "dynamodb_table" {
  source         = "git::ssh://git@github.com/pu100sh/hetzner-proxmox-terraform-modules.git//aws-dynamodb?ref=0.1"
  name           = local.dynamodb_table_name
  hash_key       = "LockID"
  read_capacity  = "5"
  write_capacity = "5"
}

module "s3" {
  source                   = "git::ssh://git@github.com/pu100sh/hetzner-proxmox-terraform-modules.git//aws-s3?ref=0.1"
  bucket_name              = local.state_bucket_name
  policy_statements        = local.state_bucket_policy
  encryption_sse_algorithm = "AES256"
  versioning_enabled       = true
}