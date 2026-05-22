variable "environment" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_task_family" {
  type = string
}

variable "ecs_container_name" {
  type = string
}

variable "ecs_container_port" {
  type = number
}

variable "ecs_cpu" {
  type = string
}

variable "ecs_memory" {
  type = string
}

variable "ecs_image" {
  type = string
}

variable "task_execution_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
