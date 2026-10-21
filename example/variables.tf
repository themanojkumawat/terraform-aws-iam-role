##-----------------------------------------------------------------------------
## Example Variables
##-----------------------------------------------------------------------------

variable "name" {
  type        = string
  default     = "my-app"
  description = "Name of the IAM role."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name (e.g. prod, dev, staging)."
}

variable "managed_by" {
  type        = string
  default     = "Terraform"
  description = "Identifier for who manages this resource."
}

variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region where resources will be created."
}

variable "policy_enabled" {
  type        = bool
  default     = true
  description = "Whether to create and attach an inline policy to the role."
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "Maximum session duration in seconds (3600–43200)."
}

variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "Whether to force detach policies before destroying the role."
}

variable "description" {
  type        = string
  default     = "IAM role for my-app EC2 instances"
  description = "Description of the IAM role."
}

variable "policy_arns" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  description = "List of managed policy ARNs to attach to the role."
}

variable "tags" {
  type        = map(string)
  default = {
    "Project" = "my-app"
    "Team"    = "devops"
  }
  description = "Additional tags to apply to all resources."
}
