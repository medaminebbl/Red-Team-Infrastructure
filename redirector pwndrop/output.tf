
output "pwn_drop_redirector_public_ip" {
  value       = aws_instance.redteam-c2-redirector.public_ip
  description = "The public IP of the pwn drop Redirector EC2 machine"
}

output "pwn_drop _redirector_private_ip" {
  value       = aws_instance.redteam-c2-redirector.private_ip
  description = "The private IP of pwn drop Redirector EC2 machine"
}

output "pwn_drop_id" {
    value     = aws_instance.redteam-c2-redirector.id
  description = "The pwn drop Redirector machine id"
} 