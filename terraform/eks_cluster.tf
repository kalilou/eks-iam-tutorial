resource "aws_eks_cluster" "this" {
  name     = "eks_iam_example"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = local.subnet_ids
    security_group_ids = [aws_security_group.control_plane_sg.id]
  }

  timeouts {
    create = "35m" # Default value is set to 20 minutes
    delete = "20m" # default value is set to 15 minutes
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "scheduler",
    "authenticator",
    "controllerManager"
  ]

  depends_on = [
    "aws_cloudwatch_log_group.this",
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.AmazonEKSServicePolicy",
 ]
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/eks/eks_iam_example/cluster"
  retention_in_days = 7

  # If you need to perform encryption use the attribute
  # kms_key_id = your_kms_alias_arn

  tags = {
    Name = "eks-cluster-example"
  }
}

data "external" "thumb" {
  program = ["kubergrunt", "eks", "oidc-thumbprint", "--issuer-url", aws_eks_cluster.this.identity.0.oidc.0.issuer]
}
# Resource for creating the OIDC provider
resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumb.result.thumbprint]
  url             = aws_eks_cluster.this.identity.0.oidc.0.issuer
}
