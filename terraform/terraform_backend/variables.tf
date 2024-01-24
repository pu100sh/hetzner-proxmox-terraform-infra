locals {
  config_name      = "terraform_backend"
  environment_name = ""
  ecosystem_name   = "root"
  project_name     = "pve"
  org_name         = "own"
  region           = "us-east-1"
  resources_name   = "own"

  dynamodb_table_name = "terraform-state-lock"
  state_bucket_name   = "${local.project_name}-tf-states"
  state_bucket_policy = [
    {
      actions = [
        "s3:*"
      ],
      effect = "Allow",
      principals = [
        {
          type = "AWS"
          identifiers = [

            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/pu100sh"

          ]
        }
      ]
      resources = [
        "arn:aws:s3:::${local.project_name}-tf-states/*",
        "arn:aws:s3:::${local.project_name}-tf-states",
      ]
    }
  ]
}
