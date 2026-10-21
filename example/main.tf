##-----------------------------------------------------------------------------
## Provider Configuration
##-----------------------------------------------------------------------------

provider "aws" {
  region = var.region
}

##-----------------------------------------------------------------------------
## Data Sources for Assume Role Policy
##-----------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
}

##-----------------------------------------------------------------------------
## IAM Role Module
##-----------------------------------------------------------------------------

module "iam_role" {
  source = "../"

  name        = var.name
  environment = var.environment
  managed_by  = var.managed_by

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  policy_enabled = var.policy_enabled
  policy         = data.aws_iam_policy_document.inline_policy.json

  policy_arns = var.policy_arns

  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies
  description           = var.description

  tags = var.tags
}
