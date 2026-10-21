##-----------------------------------------------------------------------------
## Example Outputs
##-----------------------------------------------------------------------------

output "role_id" {
  value       = module.iam_role.id
  description = "The ID of the IAM role."
}

output "role_arn" {
  value       = module.iam_role.arn
  description = "The ARN of the IAM role."
}

output "role_name" {
  value       = module.iam_role.name
  description = "The name of the IAM role."
}

output "role_unique_id" {
  value       = module.iam_role.unique_id
  description = "The stable unique identifier of the IAM role."
}

output "role_tags" {
  value       = module.iam_role.tags
  description = "Tags assigned to the IAM role."
}
