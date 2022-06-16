resource "aws_ecs_cluster" "this" {
  name = "ecs-${local.product}-${local.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Product     = local.product
    Environment = local.environment
  }
}