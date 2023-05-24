output "aws_instance_public_dns" {
  value       = aws_instance.web_server.public_dns
  sensitive   = false
  description = "description"
  depends_on  = []
}
