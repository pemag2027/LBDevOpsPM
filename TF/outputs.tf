output "public_ip" {
  description = "Public IP:"
  value       = aws_instance.ec2_ssh.public_ip
}

output "public_dns" {
  description = "Public DNS"
  value       = aws_instance.ec2_ssh.public_dns
}