# resource "aws_launch_configuration" "nginx_lcnf" {
#   image_id        = data.aws_ami.amazon-linux.id
#   name_prefix = "${var.aws_lb_project}-lc"
#   instance_type   = "t2.micro"
#   user_data       = file("nginx.sh")
#   security_groups = [aws_security_group.terramino_instance.id]

# #   lifecycle {
# #     create_before_destroy = true
# #   }
# }

resource "aws_launch_template" "nginx_lt" {
  name = "${var.aws_lb_project}-lt"
  image_id  = data.aws_ami.ec2_ami_image.id
  user_data       = filebase64("nginx.sh")
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.lt_security_group.id]

  # lifecycle {
  #   create_before_destroy = true
  # }

}

resource "aws_security_group" "lt_security_group" {
  name        = "${var.aws_lb_project}-server-sg"
  description = "EC2 Security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["94.213.52.135/32"] #Change IP Address as per your need
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.class-nginx-lb-sg.id] #Change IP Address as per your need
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = -1
  }
  
}