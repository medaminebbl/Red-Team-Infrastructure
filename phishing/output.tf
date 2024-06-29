
output "gophish_public_ip" {
  value       = aws_instance.gophish.public_ip
  description = "The public IP of the Phishing EC2 machine"
}

output "gophish_private_ip" {
  value       = aws_instance.gophish.private_ip
  description = "The private IP of the Phishing EC2 machine"
}

output "gophish_ec2_id" {
    value     = aws_instance.gophish.id
  description = "The Phishing EC2 machine id"
} 

output "evilginx_public_ip" {
  value       = aws_instance.evilginx.public_ip
  description = "The public IP of the Phishing EC2 machine"
}

output "evilginx_private_ip" {
  value       = aws_instance.evilginx.private_ip
  description = "The private IP of the Phishing EC2 machine"
}

output "evilginx_ec2_id" {
    value     = aws_instance.evilginx.id
  description = "The Phishing EC2 machine id"
} 