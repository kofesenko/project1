
resource "aws_codebuild_project" "containerAppBuild" {
  badge_enabled  = false
  build_timeout  = 60
  name           = "container-app-build"
  queued_timeout = 480
  service_role   = aws_iam_role.containerAppBuildProjectRole.arn
  tags = {
    Environment = var.env
  }

  artifacts {
    encryption_disabled = false
    packaging           = "NONE"
    type                = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }
}