output "instance_public_ip" {
	value = aws_eip.k3s.public_ip
}

output "instance_public_dns" {
	value = aws_eip.k3s.public_dns
}

output "ssh_command" {
	value = "ssh -i ~/.ssh/devops_key ubuntu@${aws_eip.k3s.public_ip}"
}