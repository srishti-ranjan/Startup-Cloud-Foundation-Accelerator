resource "aws_ecs_cluster" "this" {
  name = var.environment == "dev" ? var.ecs_cluster_name : "scfa-${var.environment}-cluster"
}

resource "aws_cloudwatch_log_group" "this" {
  name = var.environment == "dev" ? "/ecs/${var.ecs_task_family}" : "/ecs/scfa-${var.environment}-task"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "this" {
  family = var.environment == "dev" ? var.ecs_task_family : "scfa-${var.environment}-task"
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                       = var.ecs_cpu
  memory                    = var.ecs_memory
  execution_role_arn = var.task_execution_role_arn
  task_role_arn      = var.task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.ecs_container_name
      image     = var.ecs_image
      essential = true
      portMappings = [
        {
	  containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {	
    awslogs-group         = "/ecs/scfa-dev-task"
    awslogs-region        = "us-east-1"
    awslogs-stream-prefix = "ecs"
                  }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name = var.environment == "dev" ? var.ecs_service_name : "scfa-${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  depends_on = [aws_cloudwatch_log_group.this]
}


resource "aws_appautoscaling_target" "ecs" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "cpu-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 50.0

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}
