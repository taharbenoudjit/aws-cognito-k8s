resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_identifier               
  engine                  = var.engine                           
  engine_version          = var.engine_version                   
  availability_zones      = var.availability_zones              
  database_name           = var.database_name                    
  master_username         = var.master_username                 
  master_password         = var.master_password                  
  backup_retention_period = var.backup_retention_period          
  preferred_backup_window = var.preferred_backup_window          
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot     = true

  lifecycle {
    ignore_changes = [ availability_zones ]
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  # count              = var.instance_count
  identifier         = var.instance_name #"${var.instance_name}-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.insatnce_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version

    lifecycle {
    ignore_changes = [ identifier ]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.cluster_identifier}-db-subnet-group"
  subnet_ids = var.subnet_ids
}