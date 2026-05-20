output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "app_server_1_private_ip" {
  description = "Private IP of App Server 1"
  value       = aws_instance.app_1.private_ip
}

output "app_server_2_private_ip" {
  description = "Private IP of App Server 2"
  value       = aws_instance.app_2.private_ip
}

output "db_server_private_ip" {
  description = "Private IP of DB Server"
  value       = aws_instance.db.private_ip
}

output "db_connection_string" {
  description = "MySQL connection string for app servers"
  value       = "mysql -h ${aws_instance.db.private_ip} -u demouser -p demodb"
}
