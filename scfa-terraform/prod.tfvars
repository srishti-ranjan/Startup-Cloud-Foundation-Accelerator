environment = "prod"

vpc_id = "vpc-060fcaaa88c03157c"

public_subnet_ids = [
  "subnet-XXXXXXX",
  "subnet-XXXXXXX"
]

private_subnet_ids = [
  "subnet-XXXXXXX",
  "subnet-XXXXXXX"
]

alb_name = "scfa-prod-alb"

ecs_cluster_name = "scfa-prod-cluster"
ecs_service_name = "scfa-prod-service"

ecs_task_family     = "scfa-prod-task"
ecs_container_name  = "scfa-dev-app"
ecs_container_port  = 8000

ecs_cpu    = "512"
ecs_memory = "1024"

ecs_image = "097639379017.dkr.ecr.us-east-1.amazonaws.com/scfa-dev-app:latest"

task_execution_role_arn = "arn:aws:iam::097639379017:role/ecsTaskExecutionRole"

