
output "redirector_public_ip" {
  value       = aws_instance.redteam-c2-redirector.public_ip
  description = "The public IP of the Red Team Redirector EC2 machine"
}

output "redirector_private_ip" {
  value       = aws_instance.redteam-c2-redirector.private_ip
  description = "The private IP of the Red Team Redirector EC2 machine"
}

output "redteam_ec2_id" {
    value     = aws_instance.redteam-c2-redirector.id
  description = "The Red Team EC2 Redirector machine id"
} 