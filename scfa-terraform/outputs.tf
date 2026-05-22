

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}

