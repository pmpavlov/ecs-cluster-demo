resource "aws_ecs_task_definition" "main" {
  family             = "${var.name}-service-${var.environment}"
  network_mode             = "awsvpc"
#  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name         = "${var.name}-container-${var.environment}"
      image        = "${var.container_image}:latest"
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "${var.name}-log-stream-${var.environment}"
        }
      }
    }
  ])
}

