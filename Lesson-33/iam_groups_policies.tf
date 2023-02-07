#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Create IAM Group Policies from the map
#
# Made by Denis Astahov
#----------------------------------------------------------

locals {
  group_policy_map_setproduct = [
    for item in var.iam_group_map :
    setproduct([item.group_name], item.group_policies)
  ]

  group_policy_map_setproduct_pairs = [
    for item in var.iam_group_map : [
      for pair in setproduct([item.group_name], item.group_policies) : {
        group_name   = pair[0]
        group_policy = pair[1]
      }
    ]
  ]

  group_policy_map_setproduct_pairs_flatten = flatten(local.group_policy_map_setproduct_pairs)

  group_policy_map_setproduct_pairs_flatten_with_key = {
    for item in local.group_policy_map_setproduct_pairs_flatten :
    "${item.group_name}__${item.group_policy}" => item
  }


  group_map_converted = {
    for flatitem in flatten([
      for item in var.iam_group_map : [
        for pair in setproduct([item.group_name], item.group_policies) : {
          group_name   = pair[0]
          group_policy = pair[1]
        }
      ]
    ]) :
    "${flatitem.group_name}__${flatitem.group_policy}" => flatitem
  }
}

#===============================================================================
output "map_setproduct" {
  value = local.group_policy_map_setproduct
}

output "map_setproduct_pairs" {
  value = local.group_policy_map_setproduct_pairs
}

output "map_setproduct_pairs_flatten" {
  value = local.group_policy_map_setproduct_pairs_flatten
}

output "map_setproduct_pairs_flatten_with_key" {
  value = local.group_policy_map_setproduct_pairs_flatten_with_key
}

output "map_xconverted" {
  value = local.group_map_converted
}
#===============================================================================
resource "aws_iam_group_policy_attachment" "this" {
  for_each   = local.group_map_converted
  group      = each.value.group_name
  policy_arn = each.value.group_policy
  depends_on = [aws_iam_group.this]
}
#===============================================================================
