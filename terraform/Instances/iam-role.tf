resource "aws_iam_role" "jenkins" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "Jenkins-Role"
  }
}


resource "aws_iam_role_policy" "jenkins_ecr" {
  name = "jenkins-ecr-policy"
  role = aws_iam_role.jenkins.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]

        Resource = "*"
      }
    ]
  })
}


# Allow Jenkins to get EKS cluster information
resource "aws_iam_role_policy" "jenkins_eks" {
  name = "jenkins-eks-policy"
  role = aws_iam_role.jenkins.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "eks:DescribeCluster"
        ]

        Resource = "*"
      }
    ]
  })
}


# Allow Jenkins IAM Role to authenticate to EKS
resource "aws_eks_access_entry" "jenkins" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.jenkins.arn

  type = "STANDARD"
}


# Give Jenkins permissions inside EKS
resource "aws_eks_access_policy_association" "jenkins" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.jenkins.arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}


resource "aws_iam_instance_profile" "jenkins" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins.name
}

# aws eks --region us-east-1 update-kubeconfig --name retail-dev-eksdemo