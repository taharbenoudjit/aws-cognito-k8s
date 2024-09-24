user_cognito_name          = "testUserPool"
email_verification_subject = "Your Verification Code"
email_verification_message = "Please use the following code: {####}"
pwd_minimum_length         = 6
pwd_require_lowercase      = true
pwd_require_numbers        = true
pwd_require_symbols        = true
pwd_require_uppercase      = true
email_min_length           = 7
email_max_length           = 256
username_min_length        = 7
username_max_length        = 256
user_pool_client           = "testUserPoolClient"
region                     = "eu-west-1"
website_bucket_name        = "test-flutter-cloudfront-static-webapp"
logs_bucket_name           = "test-cloudfront-flutter-logs"
logging_bucket             = "test-cloudfront-flutter-logs.s3.amazonaws.com"
logging_bucket_prefix      = "flutter-logs"
restriction_type           = "whitelist"
restrictions_list          = ["FR"] # change this to the country codes you want to allow on your cloudfront
tags                       = {}
cognito_users = [
  {
    username = "testuser"
    pwd      = "Abc123@"
    email    = "testemail@gmail.com"
  },
  {
    username = "testuser2"
    pwd      = "Abc123@"
    email    = "test2email@gmail.com"
  }
]

vpc = {
  main = {
    vpc_cidr_block       = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    vpc_name             = "main"
  }
}

subnets = {
  private_a = {
    vpc_id            = "main"
    is_public_subnet  = false
    subnet_cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    tags = {
      Name                                 = "private-a"
      "kubernetes.io/role/elb"             = "1"
      "kubernetes.io/cluster/test-cluster" = "owned" # replace the test-cluster by the name you choose for the cluster, this important for your load balancer controller
    }
  },
  private_b = {
    vpc_id            = "main"
    is_public_subnet  = false
    subnet_cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-1b"
    tags = {
      Name                                 = "private-b"
      "kubernetes.io/role/elb"             = "1"
      "kubernetes.io/cluster/test-cluster" = "owned" # replace the test-cluster by the name you choose for the cluster, this important for your load balancer controller
    }
  },
  private_c = {
    vpc_id            = "main"
    is_public_subnet  = false
    subnet_cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-1c"
    tags = {
      Name                                 = "private-c"
      "kubernetes.io/role/elb"             = "1"
      "kubernetes.io/cluster/test-cluster" = "owned" # replace the test-cluster by the name you choose for the cluster, this important for your load balancer controller
    }
  },
  public_a = {
    vpc_id            = "main"
    is_public_subnet  = true
    subnet_cidr_block = "10.0.4.0/24"
    availability_zone = "eu-west-1a"
    tags = {
      Name                                 = "public-a"
      "kubernetes.io/role/elb"             = "1"
      "kubernetes.io/cluster/test-cluster" = "owned" # replace the test-cluster by the name you choose for the cluster, this important for your load balancer controller
    }
  },
  public_b = {
    vpc_id            = "main"
    is_public_subnet  = true
    subnet_cidr_block = "10.0.5.0/24"
    availability_zone = "eu-west-1b"
    tags = {
      Name                                 = "public-b"
      "kubernetes.io/role/elb"             = "1"
      "kubernetes.io/cluster/test-cluster" = "owned" # replace the test-cluster by the name you choose for the cluster, this important for your load balancer controller
    }
  }
}

rds = {
  "mysql" = {
    cluster_identifier      = "aurora-cluster-demo"
    engine                  = "aurora-mysql"
    engine_version          = "8.0.mysql_aurora.3.02.0"
    availability_zones      = ["eu-west-1a", "eu-west-1b"]
    database_name           = "mydb"
    master_username         = "foo"
    master_password         = "bartestpwd"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    instance_count          = 1
    instance_name           = "instance"
    insatnce_class          = "db.x2g.16xlarge"
  }
}

internet_gtw = {
  internet = {
    name   = "test-gateway"
    vpc_id = "main"
  }
}

nat_gateway = {
  main = {
    name      = "test-nat"
    subnet_id = "public_a"
  }
}

security_groups = {
  eks = {
    name        = "test"
    description = "for test"
    vpc_id      = "main"
    ingress_rules = [
      {
        protocol        = "tcp"
        from_port       = 443
        to_port         = 443
        security_groups = []
        cidr_blocks     = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      { protocol  = "-1"
        from_port = 0
        to_port   = 0
      cidr_blocks = ["0.0.0.0/0"] }
    ]
  }
}

budget = {
  notification = {
    name              = "test-budget"
    budget_type       = "COST"
    limit_amount      = "1200"
    limit_unit        = "USD"
    time_period_end   = "2087-06-15_00:00"
    time_period_start = "2017-07-01_00:00"
    time_unit         = "MONTHLY"
    notification = [
      {
        comparison_operator        = "GREATER_THAN"
        threshold                  = 100
        threshold_type             = "PERCENTAGE"
        notification_type          = "FORECASTED"
        subscriber_email_addresses = ["test@example.com"]
      }
    ]
  }
}

eks = {
  app = {
    cluster_name        = "test-cluster"
    cluster_version     = "1.27"
    public_access_cidrs = ["0.0.0.0/0"]
    subnet_ids          = ["public_a", "public_b", "private_a", "private_b"]
    security_groups_id  = ["eks"]
    enabled_cluster_log_types = ["api", "audit"]
  }
}

kube_system_profile = {
  system = {
    cluster_name         = "test-cluster"
    fargate_profile_name = "kube-system"
    subnet_ids           = ["private_a", "private_b"]
    namespace            = "kube-system"
  }
}

kube_profile = {
  staging = {
    cluster_name         = "test-cluster"
    fargate_profile_name = "staging"
    subnet_ids           = ["private_a", "private_b"]
    namespace            = "staging"
  }
}

route53 = {
  app = {
    domain_name = "www.swiftyboard.com"
    ttl         = 60
  }
}