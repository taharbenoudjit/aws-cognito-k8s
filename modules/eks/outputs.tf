output "eks_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "eks_certificate_authority" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "eks_id" {
  value = aws_eks_cluster.cluster.id
}