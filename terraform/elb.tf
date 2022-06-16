resource "aws_lb" "lb" {
  name               = "lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_c.id]

  enable_deletion_protection = true

  tags = {
    Environment = local.environment
  }
}

resource "aws_lb_target_group" "lb_target" {
  name     = "lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  health_check {
    enabled           = true
    path              = "/wp-admin/install.php"
    healthy_threshold = 5
  }
}