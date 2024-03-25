# terraform aws launch template
resource "aws_launch_template" "ec2_asg" {
  name                  = "my-launch-template"
  image_id              = var.ami
  instance_type         = "t2.micro"
  iam_instance_profile {
    name = var.iam_ec2_instance_profile
  }
  user_data = base64encode(templatefile(("userdata.sh"), {mysql_url = var.rds_db_endpoint}))
  vpc_security_group_ids = [var.ec2_security_group_id]
  lifecycle {
    create_before_destroy = true
  }
}


# Create Auto Scaling Group
resource "aws_autoscaling_group" "asg-tf" {
  name                 = "${var.project_name}-ASG"
  desired_capacity     = 2
  max_size             = 2
  min_size             = 1
  force_delete         = true
  depends_on           = [var.application_load_balancer]
  target_group_arns    = [var.alb_target_group_arn]
  health_check_type    = "EC2"
  launch_template {
    id      = aws_launch_template.ec2_asg.id
    version = aws_launch_template.ec2_asg.latest_version
  }
  vpc_zone_identifier  = [var.private_subnet_az1_id, var.private_subnet_az2_id]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ASG"
    propagate_at_launch = true
  }
}