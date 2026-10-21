# terraform-aws-iam-role

Terraform module to create and manage AWS IAM Roles with optional inline and managed policy attachments.

## Features

- Creates an AWS IAM Role with a configurable trust (assume role) policy
- Optionally attaches an inline policy to the role
- Optionally attaches one or more AWS managed/customer policies
- Supports permissions boundary
- Fully taggable resources
- Enable/disable creation with a single variable

## Usage

```hcl
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
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:ListBucket"]
    resources = ["*"]
  }
}

module "iam_role" {
  source = "github.com/themanojkumawat/terraform-aws-iam-role"

  name        = "my-app"
  environment = "prod"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  policy_enabled = true
  policy         = data.aws_iam_policy_document.inline_policy.json

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  tags = {
    "Project" = "my-app"
  }
}
```

## Examples

See the [example](./example) directory for a complete working example.

## Requirements

| Name      | Version    |
|-----------|------------|
| terraform | >= 1.5.0   |
| aws       | >= 5.0.0   |

## Inputs

| Name                    | Type         | Default     | Required | Description                                                    |
|-------------------------|--------------|-------------|----------|----------------------------------------------------------------|
| name                    | string       | -           | yes      | Name of the IAM role                                           |
| environment             | string       | `""`        | no       | Environment name (e.g. prod, dev, staging)                     |
| managed_by              | string       | `Terraform` | no       | Identifier for who manages this resource (used in tags)        |
| tags                    | map(string)  | `{}`        | no       | Additional tags to apply to all resources                      |
| enabled                 | bool         | `true`      | no       | Set to false to disable resource creation                      |
| assume_role_policy      | any          | -           | yes      | Trust policy JSON that grants permission to assume the role    |
| force_detach_policies   | bool         | `false`     | no       | Whether to force-detach policies before destroying the role    |
| path                    | string       | `"/"`       | no       | Path to the IAM role                                           |
| description             | string       | `""`        | no       | Description of the IAM role                                    |
| max_session_duration    | number       | `3600`      | no       | Maximum session duration in seconds (3600–43200)               |
| permissions_boundary    | string       | `null`      | no       | ARN of the IAM policy to use as a permissions boundary         |
| managed_policy_arns     | list(string) | `[]`        | no       | Exclusive set of managed policy ARNs to attach to the role     |
| policy_enabled          | bool         | `false`     | no       | Whether to create and attach an inline policy                  |
| policy                  | string       | `null`      | no       | Inline IAM policy JSON (required when policy_enabled is true)  |
| policy_arns             | list(string) | `[]`        | no       | List of managed policy ARNs to attach to the role              |

## Outputs

| Name      | Description                                          |
|-----------|------------------------------------------------------|
| id        | The ID of the IAM role                               |
| arn       | The ARN of the IAM role                              |
| name      | The name of the IAM role                             |
| unique_id | The stable unique identifier for the IAM role        |
| tags      | Tags assigned to the IAM role                        |

## License

MIT License. See [LICENSE](LICENSE) for details.
