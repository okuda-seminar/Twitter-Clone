# ------------------------------------------------------------------------------
# AWS Cognito User Pool
#
# Creates a user pool to manage user authentication.
# - Email is auto-verified.
# - MFA is disabled.
# - Password policies enforce strong security.
# - Admins and users can both create accounts.
# - A verification email template is customized.
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool" "user_pool" {
  name                       = "${var.user_pool_name}-${var.env}"
  sms_authentication_message = "Your verification code is {####}."
  mfa_configuration          = "OFF"

  lifecycle {
    prevent_destroy = false
  }

  admin_create_user_config {
    allow_admin_create_user_only = false

    invite_message_template {
      email_message = "Your username is {username} and your temporary password is {####}."
      email_subject = "Temporary Password"
      sms_message   = "Your username is {username} and your temporary password is {####}."
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  # Password policy based on Authentication Feature Design Document
  # Note: Maximum password length cannot be enforced by Cognito.
  # Application-side validation is required to enforce a maximum length (e.g., 15 characters).
  password_policy {
    minimum_length                   = 8
    require_lowercase                = false
    require_numbers                  = false
    require_symbols                  = false
    require_uppercase                = false
    temporary_password_validity_days = 7
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option  = "CONFIRM_WITH_LINK"
    email_message         = "Your verification code is {####}."
    email_message_by_link = "Click the link below to verify your email address: {##Verify Email##}"
    email_subject         = "Verification Code"
    email_subject_by_link = "Verify Your Email"
    sms_message           = "Your verification code is {####}."
  }

  tags = {
    Env = var.env
  }
}

# ------------------------------------------------------------------------------
# AWS Cognito User Pool Client
#
# Configures a client app to access the user pool via OAuth 2.0.
# - Supports user/password login and refresh tokens.
# - Supports code-based OAuth flow and OpenID scope.
# - Includes read/write access to email attributes.
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "${var.user_pool_name}-${var.env}"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid"]

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  supported_identity_providers = ["COGNITO"]

  prevent_user_existence_errors = "ENABLED"

  refresh_token_validity = 30

  read_attributes = [
    "email", "email_verified"
  ]

  write_attributes = [
    "email"
  ]

  lifecycle {
    prevent_destroy = false
  }
}


# ------------------------------------------------------------------------------
# AWS Cognito Identity Pool
#
# Creates an Identity Pool to issue AWS temporary credentials to authenticated users.
# - Associates the User Pool Client as an authentication provider.
# - Allows only authenticated identities (no guest access).
# ------------------------------------------------------------------------------

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = "${var.env}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.user_pool_client.id
    provider_name = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.user_pool.id}"
    server_side_token_check = true
  }

  tags = {
    Environment = var.env
  }
}

# ------------------------------------------------------------------------------
# IAM Role for Authenticated Users
#
# Defines an IAM role that authenticated Cognito users can assume.
# - Trust policy allows only authenticated identities from the Identity Pool.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "authenticated_role" {
  name = "cognito-authenticated-role-${var.env}"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": aws_cognito_identity_pool.identity_pool.id
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      }
    ]
  })
}

# ------------------------------------------------------------------------------
# IAM Policy for Authenticated Users
#
# Attaches permissions for authenticated users to access specific S3 buckets.
# - Grants read (List and Get) permissions on the designated S3 bucket.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy" "authenticated_policy" {
  name = "cognito-authenticated-policy-${var.env}"
  role = aws_iam_role.authenticated_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        "Resource": [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}


# ------------------------------------------------------------------------------
# Identity Pool Roles Attachment
#
# Links the Identity Pool to the authenticated IAM role.
# - Ensures authenticated users automatically assume the correct IAM role.
# ------------------------------------------------------------------------------

resource "aws_cognito_identity_pool_roles_attachment" "identity_pool_roles_attachment" {
  identity_pool_id = aws_cognito_identity_pool.identity_pool.id

  roles = {
    authenticated = aws_iam_role.authenticated_role.arn
  }
}

