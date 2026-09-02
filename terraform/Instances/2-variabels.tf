variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "instances_running" {
  description = "Whether to create the EC2 instances"
  type        = bool
  default     = false
}
variable "cluster_name" {
  type        = string
  default     = "retail-dev-eksdemo"
}
