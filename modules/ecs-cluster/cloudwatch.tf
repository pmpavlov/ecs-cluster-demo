########################################################################################################################
## Create log group for our service
########################################################################################################################

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/${lower(var.environment)}/ecs/${var.name}"
  retention_in_days = var.retention_in_days
}
