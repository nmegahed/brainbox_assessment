output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "The public IP address assigned to the instance (if applicable)"
  value       = aws_instance.this.public_ip
}

output "availability_zone" {
  description = "The availability zone where the instance is launched"
  value       = aws_instance.this.availability_zone
}

output "instance_name" {
  description = "The Name tag of the EC2 instance"
  value       = lookup(aws_instance.this.tags, "Name", "not-set")
}

output "private_dns" {
  description = "The private DNS name assigned to the instance"
  value       = aws_instance.this.private_dns
}

output "security_group_id" {
    description = "The Security group id of the instance"
    value = aws_security_group.this.id
}
