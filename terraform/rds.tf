resource "aws_db_instance" "default" {
	identifier = "${local.product}-${local.environment}"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  db_name              = "rds"
  username             = "admin"
  password             = "Dummy12345" # TODO: You NEED to change db password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
	db_subnet_group_name =  aws_db_subnet_group.db_subnet.name
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_c.id]

  tags = {
    Name = "RDS for MySQL"
  }
}
