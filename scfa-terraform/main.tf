module "security" {
  source = "./modules/security"

  environment = var.environment

  vpc_id   = var.vpc_id
  alb_name = var.alb_name
  ecs_name = var.ecs_cluster_name
}

module "alb" {
  source = "./modules/alb"

  environment           = var.environment
  alb_name              = var.alb_name
  vpc_id                = var.vpc_id
  public_subnet_ids     = var.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  target_group_arn      = aws_lb_target_group.this.arn
}

resource "aws_lb_target_group" "this" {
  name = var.environment == "dev" ? "scfa-dev-tg" : "scfa-${var.environment}-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

module "ecs" {
  source = "./modules/ecs"

  environment              = var.environment
  ecs_cluster_name         = var.ecs_cluster_name
  ecs_service_name         = var.ecs_service_name
  private_subnet_ids       = var.private_subnet_ids
  ecs_security_group_id    = module.security.ecs_security_group_id
  target_group_arn         = aws_lb_target_group.this.arn
  ecs_container_name       = var.ecs_container_name
  ecs_container_port       = var.ecs_container_port
  ecs_task_family          = var.ecs_task_family
  ecs_cpu                  = var.ecs_cpu
  ecs_memory               = var.ecs_memory
  ecs_image                = var.ecs_image
  task_execution_role_arn  = var.task_execution_role_arn
}
