##-----------------------------------------------------------------------------
## IAM Role Outputs
##-----------------------------------------------------------------------------

output "id" {
  value       = try(aws_iam_role.this[0].id, null)
  description = "The ID of the IAM role."
}

output "arn" {
  value       = try(aws_iam_role.this[0].arn, null)
  description = "The ARN of the IAM role."
}

output "name" {
  value       = try(aws_iam_role.this[0].name, null)
  description = "The name of the IAM role."
}

output "unique_id" {
  value       = try(aws_iam_role.this[0].unique_id, null)
  description = "The stable and unique string identifying the IAM role."
}

output "tags" {
  value       = try(aws_iam_role.this[0].tags_all, {})
  description = "A map of tags assigned to the IAM role."
}
