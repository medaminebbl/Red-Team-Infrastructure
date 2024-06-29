output "pwn_drop_public_ip" {
  value       = aws_instance.pwn_drop.public_ip
  description = "The public IP of the pwn drop server"
}

output "pwn_drop_private_ip" {
  value       = aws_instance.pwn_drop.private_ip
  description = "The private IP of the pwn drop server"
}

output "pwn_drop_id" {
    value     = aws_instance.redteam-c2.id
  description = "The pwn drop server id"
} 