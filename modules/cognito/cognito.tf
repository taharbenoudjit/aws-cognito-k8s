resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_cognito_name

  email_verification_subject = var.email_verification_subject
  email_verification_message = var.email_verification_message
  alias_attributes           = ["email"]
  auto_verified_attributes   = ["email"]

  password_policy {
    minimum_length    = var.pwd_minimum_length
    require_lowercase = var.pwd_require_lowercase
    require_numbers   = var.pwd_require_numbers
    require_symbols   = var.pwd_require_symbols
    require_uppercase = var.pwd_require_uppercase
  }

  username_configuration {
    case_sensitive = false
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = var.email_min_length
      max_length = var.email_max_length
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      min_length = var.username_min_length
      max_length = var.username_max_length
    }
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                = var.user_pool_client
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]

  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "null_resource" "register_user" {
  count = length(var.cognito_users)

  triggers = {
    "users" = length(var.cognito_users)
  }

  provisioner "local-exec" {
    command = "aws cognito-idp sign-up --client-id ${aws_cognito_user_pool_client.user_pool_client.id} --username ${var.cognito_users[count.index].username} --password ${var.cognito_users[count.index].pwd} --user-attributes Name=name,Value=${var.cognito_users[count.index].username} Name=email,Value=${var.cognito_users[count.index].email}"
  }

  depends_on = [
    aws_cognito_user_pool.user_pool,
    aws_cognito_user_pool_client.user_pool_client
  ]
}

resource "null_resource" "validate_user" {
  count = length(var.cognito_users)

  triggers = {
    "users" = length(var.cognito_users)
  }

  provisioner "local-exec" {
    command = "aws cognito-idp admin-confirm-sign-up --user-pool-id ${aws_cognito_user_pool.user_pool.id} --username ${var.cognito_users[count.index].username}"
  }

  depends_on = [
    null_resource.register_user
  ]
}
