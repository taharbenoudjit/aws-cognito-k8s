resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster-${var.cluster_name}"

  assume_role_policy = file("${path.module}/templates/cluster-role.json")
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks-cluster.arn
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = var.public_access_cidrs
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_groups_id
  }

  encryption_config {
    provider {
      key_arn = var.kms_arn
    }
    resources = ["secrets"]
  }

  depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy]
}
