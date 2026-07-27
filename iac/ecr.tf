resource "aws_ecr_repository" "cicd_estudos" {
  name = "cicd_estudos"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Iac = "true"
  }
}
