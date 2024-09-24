module "cognito" {
  source                     = "./modules/cognito"
  user_cognito_name          = var.user_cognito_name
  email_verification_subject = var.email_verification_subject
  email_verification_message = var.email_verification_message
  pwd_minimum_length         = var.pwd_minimum_length
  pwd_require_lowercase      = var.pwd_require_lowercase
  pwd_require_numbers        = var.pwd_require_numbers
  pwd_require_symbols        = var.pwd_require_symbols
  pwd_require_uppercase      = var.pwd_require_uppercase
  email_min_length           = var.email_min_length
  email_max_length           = var.email_max_length
  username_min_length        = var.username_min_length
  username_max_length        = var.username_max_length
  user_pool_client           = var.user_pool_client
  cognito_users              = var.cognito_users
}

data "template_file" "env_file" {
  template = "${file("${path.cwd}/templates/.env")}"
  vars = {
    pool_id = "${module.cognito.user_pool_id}"
    client_id = "${module.cognito.user_pooli_client_id}"
  }

  depends_on = [ module.cognito ]
}

resource "local_file" "env_build" {
  content  = data.template_file.env_file.rendered
  filename = "${path.cwd}/code/build/web/assets/.env"
  depends_on = [ data.template_file.env_file ]
}

resource "local_file" "env_app" {
  content  = data.template_file.env_file.rendered
  filename = "${path.cwd}/code/.env"
  depends_on = [ data.template_file.env_file ]
}


module "website_bucket" {
  source      = "./modules/s3_website"
  bucket_name = var.website_bucket_name
  code_path = "${path.cwd}/code/build/web"

  depends_on = [ 
      local_file.env_build,
      local_file.env_app
   ]
}

module "logs_bucket" {
  source      = "./modules/s3"
  bucket_name = var.logs_bucket_name
}

module "route53" {
  source      = "./modules/route53"
  for_each    = var.route53
  domain_name = each.value.domain_name
  ttl         = each.value.ttl
}

module "cloudfront" {
  source                     = "./modules/cloudfront"
  origin_bucket_domaine_name = module.website_bucket.bucket_domain_name
  origin_bucket_id           = module.website_bucket.bucket_id
  logging_bucket             = module.logs_bucket.bucket_domain_name
  logging_bucket_prefix      = var.logging_bucket_prefix
  restriction_type           = var.restriction_type
  restrictions_list          = var.restrictions_list
  route53_zone_id            = module.route53["app"].route53_zone_id
  domain_name                = "www.swiftyboard.com"
  cert_domain                = module.route53["app"].cert_arn
  tags                       = {}

  depends_on = [
    module.website_bucket,
    module.logs_bucket,
    module.route53
  ]
}

module "vpc" {
  source               = "./modules/vpc"
  for_each             = var.vpc
  vpc_cidr_block       = each.value.vpc_cidr_block
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  vpc_name             = each.value.vpc_name
}

module "subnet" {
  source            = "./modules/subnet"
  for_each          = var.subnets
  vpc_id            = module.vpc[each.value.vpc_id].vpc_id
  is_public_subnet  = each.value.is_public_subnet
  subnet_cidr_block = each.value.subnet_cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value.tags
}

module "internet_gateway" {
  source   = "./modules/internet_gtw"
  for_each = var.internet_gtw
  vpc_id   = module.vpc[each.value.vpc_id].vpc_id
  name     = each.value.name
}

module "nat_gateway" {
  source    = "./modules/nat_gtw"
  for_each  = var.nat_gateway
  subnet_id = module.subnet[each.value.subnet_id].subnet_id
  name      = each.value.name

  depends_on = [
    module.internet_gateway
  ]
}

module "security_group" {
  source        = "./modules/security_groups"
  for_each      = var.security_groups
  name          = each.value.name
  description   = each.value.description
  vpc_id        = module.vpc[each.value.vpc_id].vpc_id
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
}

module "rds" {
  source             = "./modules/rds"
  for_each           = var.rds
  cluster_identifier = each.value.cluster_identifier
  engine             = each.value.engine
  engine_version     = each.value.engine_version
  availability_zones = each.value.availability_zones
  database_name      = each.value.database_name
  master_username    = each.value.master_username
  master_password    = each.value.master_password
  # backup_retention_period = each.value.backup_retention_period
  # preferred_backup_window = each.value.preferred_backup_window
  instance_count = each.value.instance_count
  instance_name  = each.value.instance_name
  insatnce_class = each.value.insatnce_class
  subnet_ids     = [module.subnet["private_a"].subnet_id, module.subnet["private_b"].subnet_id]


  depends_on = [
    module.subnet
  ]
}

module "budget" {
  source            = "./modules/budget"
  for_each          = var.budget
  name              = each.value.name
  budget_type       = each.value.budget_type
  limit_amount      = each.value.limit_amount
  limit_unit        = each.value.limit_unit
  time_period_end   = each.value.time_period_end
  time_period_start = each.value.time_period_start
  time_unit         = each.value.time_unit
  notification      = each.value.notification
}

resource "aws_kms_key" "eks_kms" {
  description             = "eks kms"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "eks_cloudwatch" {
  name              = "/aws/eks/${var.eks["app"].cluster_name}/cluster"
  retention_in_days = 7
}

module "eks" {
  source              = "./modules/eks"
  for_each            = var.eks
  cluster_name        = each.value.cluster_name
  cluster_version     = each.value.cluster_version
  public_access_cidrs = each.value.public_access_cidrs
  subnet_ids          = [for subnet in each.value.subnet_ids : module.subnet[subnet].subnet_id]
  security_groups_id  = []#[for grp in each.value.security_groups_id : module.security_group[grp].grp_id]
  enabled_cluster_log_types = each.value.enabled_cluster_log_types
  kms_arn = aws_kms_key.eks_kms.arn

  depends_on = [ aws_kms_key.eks_kms, aws_cloudwatch_log_group.eks_cloudwatch]
}

# ################## connect to the eks cluster ############

resource "null_resource" "update_kube_config" {
  triggers = {
    run = uuid()
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks["app"].eks_id} --region ${var.region}"
  }

  depends_on = [ module.eks ]
}

# ################# system profile ########################

module "kube_system_profile" {
  source                 = "./modules/kube_profile"
  for_each               = var.kube_system_profile
  cluster_name           = each.value.cluster_name
  fargate_profile_name   = each.value.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn
  subnet_ids             = [for subnet in each.value.subnet_ids : module.subnet[subnet].subnet_id]
  namespace              = each.value.namespace
  depends_on = [ 
    module.eks,
    null_resource.update_kube_config
   ]
}

# ################## patch eks coreDns ############

resource "null_resource" "kubectl_patch" {
  triggers = {
    run = "${module.kube_system_profile["system"].profile_id}"
  }

  provisioner "local-exec" {
    command = <<EOT
    kubectl patch deployment coredns -n kube-system  --type json -p=${jsonencode([{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}])}
EOT
}

  depends_on = [ module.kube_system_profile, null_resource.update_kube_config ]
}

# ############ stagging profile #####################

module "kube_profile" {
  source                 = "./modules/kube_profile"
  for_each               = var.kube_profile
  cluster_name           = each.value.cluster_name
  fargate_profile_name   = each.value.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn
  subnet_ids             = [for subnet in each.value.subnet_ids : module.subnet[subnet].subnet_id]
  namespace              = each.value.namespace
  depends_on = [ 
    module.eks,
    null_resource.kubectl_patch
   ]
}

module "eks_autoscalling" {
  source                    = "./modules/eks_autoscalling"
  eks_endpoint              = module.eks["app"].eks_endpoint
  eks_certificate_authority = module.eks["app"].eks_certificate_authority
  cluster_id                = module.eks["app"].eks_id
  release_version           = "3.8.2"
}

output "user_pool_id" {
  value = module.cognito.user_pool_id
}

output "user_pooli_client_id" {
  value = module.cognito.user_pooli_client_id
}