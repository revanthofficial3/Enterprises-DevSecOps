# Terraform - Existing Kubernetes Master and Worker Instances
# -------------------------------------------------------------
# This file imports the two existing EC2 instances into Terraform state.
# It does NOT create/recreate new EC2 instances.
#
# Existing project instances:
#   k8s-master
#   k8s-worker
#
# Replace the instance IDs below with the actual IDs from your AWS account
# before running terraform import.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Existing Kubernetes master instance
resource "aws_instance" "k8s_master" {
  # Configuration is managed by the existing AWS instance.
  # The resource is imported into Terraform state.
}

# Existing Kubernetes worker instance
resource "aws_instance" "k8s_worker" {
  # Configuration is managed by the existing AWS instance.
  # The resource is imported into Terraform state.
}
