output "bastion-eip" {
    value = aws_eip.bastion-eip.*.public_ip
}

output "bastion-private-ip" {
    value = aws_instance.bastion-server.*.private_ip
}

output "bastion-sg-ssh" {
    value = aws_security_group.bastion-sg-ssh.id
}

