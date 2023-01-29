# resource "aws_instance" "class-ec2-server" {
#   instance_type = var.ec2_instance_type #Refer value from ec2_instance_type variable
#   ami = data.aws_ami.ec2_ami_image.id
#   vpc_security_group_ids = [aws_security_group.class-ec2-server-sg.id]
#   key_name = "jenkins-slave"
#   user_data = file("nginx.sh")
#   count = var.ec2_instance_count
#   tags = {
#     "Name" = "${var.aws_lb_project}-${count.index}"
#   }
# }

# resource "aws_security_group" "class-ec2-server-sg" {
#   name        = "${var.aws_lb_project}-ec2-security-group"
#   description = "EC2 Security group"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["94.213.52.135/32"] #Change IP Address as per your need
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     #security_groups = [aws_security_group.class-nginx-lb-sg.id] #Change IP Address as per your need
#   }
#   egress {
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#   }
  
# }

