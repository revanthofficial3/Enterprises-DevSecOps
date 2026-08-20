output "k8s_master_instance_id" {
  description = "Kubernetes master EC2 instance ID"
  value       = aws_instance.k8s_master.id
}

output "k8s_master_private_ip" {
  description = "Kubernetes master private IP"
  value       = aws_instance.k8s_master.private_ip
}

output "k8s_worker_instance_id" {
  description = "Kubernetes worker EC2 instance ID"
  value       = aws_instance.k8s_worker.id
}

output "k8s_worker_private_ip" {
  description = "Kubernetes worker private IP"
  value       = aws_instance.k8s_worker.private_ip
}
