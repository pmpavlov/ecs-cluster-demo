resource "aws_ecs_cluster_capacity_providers" "main-cp" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy  {
    capacity_provider = "FARGATE_SPOT"
    weight            = 0
    base              = 0
  }
}
