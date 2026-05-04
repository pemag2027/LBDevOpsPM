terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
# ECR Repository
  resource "aws_ecr_repository" "python_calculator" {
  name = var.repository_name

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {

    scan_on_push = true

  }



  tags = {
    Environment = var.environment
    Project = "DevOps-Course"
    Lesson = "5"
  }
}

# ECR Lifecycle Policy

  resource "aws_ecr_lifecycle_policy" "python_calculator_policy" {
  repository = aws_ecr_repository.python_calculator.name
  
  policy = jsonencode({

    rules = [
      {

        rulePriority = 1
        description = "Keep last 10 images"
        selection = {
          tagStatus = "tagged"
          tagPrefixList = ["v"]
          countType = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# ECR IAM Policy

resource "aws_iam_policy" "ecr_push_policy" {
  name = "ecr-push-python_calculator}"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "ECRAuthToken",
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      },
     
      {
        Sid    = "ECRPushPullRepo",
        Effect = "Allow",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:DescribeRepositories",
          "ecr:ListImages"
        ],
        Resource = aws_ecr_repository.python_calculator.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ecr_push" {
  role       = aws_iam_role.github_actions_ecr_push.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}


