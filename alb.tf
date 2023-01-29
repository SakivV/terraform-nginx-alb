resource "aws_security_group" "nginx_lb_sg" {
  name        = "${var.aws_lb_project}-lb-security-group"
  description = "NGINX Securiy group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = -1
  }
}

resource "aws_alb_target_group" "nginx_target_group" {
    name = "${var.aws_lb_project}-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "instance" # This is default
    vpc_id = "vpc-0f27b8fe4a7ac492c"
}

resource "aws_alb" "nginx_alb" {
  internal = false
  name = "${var.aws_lb_project}-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.nginx_lb_sg.id]
  subnets = ["subnet-0ee719433e9ce8ecb","subnet-0b482f3f4e26d23fb"]
  depends_on = [aws_launch_template.nginx_lt]
}


# Registering instances
resource "aws_autoscaling_attachment" "nginx_alb_attachment" {
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.id
  alb_target_group_arn = aws_alb_target_group.nginx_target_group.arn
}

# Create ALB Listner
resource "aws_alb_listener" "nginx_alb_listner" {
    load_balancer_arn = aws_alb.nginx_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.nginx_target_group.arn
    }
}

