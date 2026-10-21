##-----------------------------------------------------------------------------
## General Variables
##-----------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "Name of the IAM role (e.g. `app`, `api`, `service`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment name (e.g. `prod`, `dev`, `staging`)."
}

variable "managed_by" {
  type        = string
  default     = "Terraform"
  description = "Identifier for who manages this resource (used in tags)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to all resources."
}

##-----------------------------------------------------------------------------
## IAM Role Variables
##-----------------------------------------------------------------------------

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to disable creation of the IAM role and related resources."
}

variable "assume_role_policy" {
  type        = any
  description = "The trust policy (JSON) that grants an entity permission to assume the role."
  sensitive   = true
}

variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "Whether to force detaching any policies before destroying the role."
}

variable "path" {
  type        = string
  default     = "/"
  description = "The path to the IAM role."
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the IAM role."
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "Maximum session duration (in seconds) for the role. Value must be between 3600 and 43200."

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 (1 hour) and 43200 (12 hours)."
  }
}

variable "permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the IAM policy to use as a permissions boundary for the role."
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role."
}

##-----------------------------------------------------------------------------
## Inline Policy Variables
##-----------------------------------------------------------------------------

variable "policy_enabled" {
  type        = bool
  default     = false
  description = "Whether to create an inline policy and attach it to the role."
}

variable "policy" {
  type        = string
  default     = null
  description = "Inline IAM policy JSON to attach to the role. Required when policy_enabled is true."
}

##-----------------------------------------------------------------------------
## Additional Policy Attachments
##-----------------------------------------------------------------------------

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM managed policy ARNs to attach to the role."
}
