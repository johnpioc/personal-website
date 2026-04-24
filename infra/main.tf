resource "aws_ssm_parameter" "test" {
  name  = "/${var.project_name}/pipeline-test"
  type  = "String"
  value = "pipeline works"
}
