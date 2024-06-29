
output "caldera_public_ip" {
  value       = aws_instance.redteam-c2.public_ip
  description = "The public IP of the redteam EC2 machine"
}

output "caldera_private_ip" {
  value       = aws_instance.redteam-c2.private_ip
  description = "The private IP of the redteam EC2 machine"
}

output "redteam_ec2_id" {
    value     = aws_instance.redteam-c2.id
  description = "The redteam EC2 machine id"
} 