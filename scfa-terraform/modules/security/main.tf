resource "aws_security_group" "alb_sg" {
  name = var.environment == "dev" ? "scfa-dev-alb-sg" : "scfa-${var.environment}-alb-sg"

  description = "Security group for SCFA ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {}


  lifecycle {
  prevent_destroy = true
}

}

resource "aws_security_group" "ecs_sg" {
  name = var.environment == "dev" ? "scfa-dev-ecs-sg" : "scfa-${var.environment}-ecs-sg"
  description = "Security group for SCFA ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  tags = {}
}

