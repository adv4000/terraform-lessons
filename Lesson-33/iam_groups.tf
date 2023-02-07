#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Create IAM Groups from the map
#
# Made by Denis Astahov
#----------------------------------------------------------

locals {
  group_map_with_key = { for item in var.iam_group_map : item.group_name => item }
}

#===============================================================================
output "iam_group_map_with_key" {
  value = local.group_map_with_key
}

#===============================================================================
resource "aws_iam_group" "this" {
  for_each = local.group_map_with_key
  name     = each.key
}
#===============================================================================
