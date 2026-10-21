##-----------------------------------------------------------------------------
## Provider Configuration
##-----------------------------------------------------------------------------

provider "aws" {
  region = "ap-south-1"
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
## IAM Role Module - Basic Example (EC2 Instance Role)
##-----------------------------------------------------------------------------

module "iam_role" {
  source = "../"

  name        = "my-app"
  environment = "dev"
  managed_by  = "Terraform"

  # Trust policy - allows EC2 to assume this role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  # Optional: attach an inline policy
  policy_enabled = true
  policy         = data.aws_iam_policy_document.inline_policy.json

  # Optional: attach AWS managed policies
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  max_session_duration  = 3600
  force_detach_policies = false
  description           = "IAM role for my-app EC2 instances"

  tags = {
    "Project" = "my-app"
    "Team"    = "devops"
  }
}

##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------

output "role_arn" {
  value       = module.iam_role.arn
  description = "ARN of the created IAM role."
}

output "role_name" {
  value       = module.iam_role.name
  description = "Name of the created IAM role."
}
