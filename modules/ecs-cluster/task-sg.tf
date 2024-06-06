resource "aws_security_group" "ecs_tasks" {
  name   = "${var.name}-sg-task-${var.environment}"
  vpc_id = var.vpc_id
 
  ingress {
   security_groups   = [aws_security_group.alb-sg.id]
   protocol          = "tcp"
   from_port         = var.container_port
   to_port           = var.container_port
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}
