// Print all details
output "created_iam_users_all" {
  value = aws_iam_user.users
}

//Print only ID of users
output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

//Print my Custom output list
output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

//Print My Custom output MAP
output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id // "AIDA4BML4STW22K74HQFF" : "vasya"
  }
}

// Print List of users with name 4 characters ONLY
output "custom_if_length" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}

#===================================================================

// Print nice MAP of InstanceID: PublicIP
output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip // "i-0490f049844513179" = "99.79.58.22"
  }
}
