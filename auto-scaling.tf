resource "aws_autoscaling_group" "nginx_asg" {
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier = ["subnet-0ee719433e9ce8ecb","subnet-0b482f3f4e26d23fb"]
  #launch_configuration = aws_launch_configuration.nginx_lcnf.name
  #vpc_zone_identifier  = module.vpc.public_subnets
  launch_template {
    id = aws_launch_template.nginx_lt.id
  }
}