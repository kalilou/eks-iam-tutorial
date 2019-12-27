resource "aws_security_group" "control_plane_sg" {
  name        = "allow_tls"
  description = "EKS control plane security group"
  vpc_id      = ""

  # Allow worker node to communicate with eks cluster
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    self = true
  }

  # Allow eks to access the internet
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
