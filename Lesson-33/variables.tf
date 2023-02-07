variable "iam_group_map" {
  default = [
    {
      group_name = "Developers"
      group_policies = [
        "arn:aws:iam::aws:policy/AWSProtonDeveloperAccess",
        "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
      ]
    },
    {
      group_name = "SysOps"
      group_policies = [
        "arn:aws:iam::aws:policy/job-function/SystemAdministrator",
        "arn:aws:iam::aws:policy/job-function/NetworkAdministrator",
        "arn:aws:iam::aws:policy/AWSSecurityHubReadOnlyAccess"
      ]
    },
    {
      group_name     = "Administrators"
      group_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    },
    {
      group_name = "SecurityAuditors"
      group_policies = [
        "arn:aws:iam::aws:policy/SecurityAudit",
        "arn:aws:iam::aws:policy/AWSSecurityHubReadOnlyAccess"
      ]
    }
  ]
}
