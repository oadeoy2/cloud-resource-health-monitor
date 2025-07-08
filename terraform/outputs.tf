output "jenkins_private_key_pem" {
  value     = module.jenkins_ec2.jenkins_private_key_pem
  sensitive = true
}

output "jenkins_public_ip" {
  value = module.jenkins_ec2.jenkins_public_ip
}