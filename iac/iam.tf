import {
  to = aws_iam_openid_connect_provider.oidc-git
  id = "arn:aws:iam::831181104004:oidc-provider/token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "oidc-git" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  tags = {
    Iac = "true"
  }
}

resource "aws_iam_role" "ecr_role" {
  name = "ecr_role"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Principal" : {
            "Federated" : "arn:aws:iam::831181104004:oidc-provider/token.actions.githubusercontent.com"
          },
          "Condition" : {
            "StringEquals" : {
              "token.actions.githubusercontent.com:aud" : [
                "sts.amazonaws.com"
              ]
            },
            "StringLike" : {
              "token.actions.githubusercontent.com:sub" : [
                "repo:ArtuurDev/CI-CD-estudos:*",
                "repo:artuurdev/ci-cd-estudos:*",
                "repo:ArtuurDev*/CI-CD-estudos*",
                "repo:artuurdev*/ci-cd-estudos*"
              ]
            }
          }
        }
      ]
  })

  tags = {
    Iac = "true"
  }
}

resource "aws_iam_role_policy" "erc_policy" {
  name = "ecr_policy"
  role = aws_iam_role.ecr_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Statement1"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

}
