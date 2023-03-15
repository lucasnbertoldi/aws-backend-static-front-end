resource "aws_launch_template" "launch_template" {
  name = join("-", [var.env, var.id, "launch_template"])
  vpc_security_group_ids = [aws_security_group.e2c_application_security_group.id]

  image_id = var.ami_id

  instance_type = var.e2c_application_instance_type

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.e2c_application_volume_size
      delete_on_termination = true
      encrypted = false
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = join("-", [var.env, var.id, "launch-template"])
      Environment = var.env
    }
  }
}

resource "aws_placement_group" "placement" {
  name     = join("-", [var.env, var.id, "placement-group"])
  strategy = "spread"
}

resource "aws_autoscaling_group" "autoscaling" {
  name                      = join("-", [var.env, var.id, "autoscaling-group"])
  
  max_size                  = 4
  min_size                  = 1
  desired_capacity          = 2

  health_check_grace_period = 300
  health_check_type         = "EC2"
  
  force_delete              = true

  placement_group           = aws_placement_group.placement.id
  vpc_zone_identifier       = aws_subnet.subnet[*].id

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.target_group.arn
  ]

}

resource "aws_autoscaling_policy" "policy" {
  name                   = join("-", [var.env, var.id, "policy"])
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.auto_scaling_cpu_percentage
  }
}