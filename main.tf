##-----------------------------------------------------------------------------
## IAM Role Resource
## Creates and manages an AWS IAM Role with optional inline and managed policies.
##-----------------------------------------------------------------------------

locals {
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.environment
      "ManagedBy"   = var.managed_by
    },
    var.tags
  )
}

##-----------------------------------------------------------------------------
## AWS IAM Role
##-----------------------------------------------------------------------------
resource "aws_iam_role" "this" {
  count = var.enabled ? 1 : 0

  name                  = "${var.name}-${var.environment}"
  assume_role_policy    = var.assume_role_policy
  force_detach_policies = var.force_detach_policies
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  managed_policy_arns   = var.managed_policy_arns

  tags = local.tags
}

##-----------------------------------------------------------------------------
## Inline Policy (optional)
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy" "this" {
  count = var.enabled && var.policy_enabled ? 1 : 0

  name   = "${var.name}-${var.environment}-policy"
  role   = aws_iam_role.this[0].id
  policy = var.policy
}

##-----------------------------------------------------------------------------
## Attach additional managed policies to the role (optional)
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.enabled ? toset(var.policy_arns) : toset([])

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
