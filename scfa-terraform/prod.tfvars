
environment = "prod"

vpc_id = "vpc-060fcaaa88c03157c"

public_subnet_ids = [
  "subnet-035a94edb9d8e8a3d",
  "subnet-0edae7ceaea0b596d"
]

private_subnet_ids = [
  "subnet-0bb3cde061b00cfbd",
  "subnet-0f88d824890e64c11"
]

min_capacity = 2
max_capacity = 5


alb_name = "scfa-prod-alb"

ecs_cluster_name = "scfa-prod-cluster"
ecs_service_name = "scfa-prod-service"

ecs_task_family     = "scfa-prod-task"
ecs_container_name  = "scfa-dev-app"
ecs_container_port  = 8000

ecs_cpu    = "1024"
ecs_memory = "2048"

ecs_image = "097639379017.dkr.ecr.us-east-1.amazonaws.com/scfa-dev-app:latest"

task_execution_role_arn = "arn:aws:iam::097639379017:role/ecsTaskExecutionRole"

