resource "aws_security_group" "elb_sg" {
  name        = "elb"
  description = "elb"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTP From Anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web"
  description = "web"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "HTTP From LB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  tags = {
    Name = "allow_http_from_elb"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db"
  description = "db"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "RDS From Web"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  tags = {
    Name = "allow_db_from_web"
  }
}