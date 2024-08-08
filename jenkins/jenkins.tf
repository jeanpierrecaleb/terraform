resource "aws_instance" "jenkins_ec2" {
  # vpc_id = var.j_ivpc
  subnet_id       = var.j_isubnet
  ami             = var.j_iami
  instance_type   = var.j_itype
  security_groups = var.j_isgp
  key_name        = var.my_key_name
  tags = {
    Name = var.j_iname
  }

  # Use remote-exec to run commands on the instance

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y              
              EOF

  # end of user data oh
  ## yum install -y httpd
  ##  service httpd start
  ##  echo "Hello, World!" > /var/www/html/index.html
  ###sudo amazon-linux-extras install epel -y
  ###sudo yum install -y ansible
  ### sudo yum install python3 -y

  ##provisioner "local-exec" {
  ##  command = "ansible-playbook -i ${self.public_ip}, ansible/provision_jenkins.yaml"
  ##}

  /* provisioner "remote-exec" {
    inline = [
      "echo 'Cette commande s'exécute sur l'instance distante.'",
      "sudo yum install -y httpd",
      "sudo service httpd start"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user" # Nom d'utilisateur sur l'instance
      private_key = file("~/.ssh/${var.my_key_name}") # Chemin vers votre clé privée
      host        = self.public_ip
    }
  }*/

}

output "j_ip_address" {
  value = aws_instance.jenkins_ec2.public_ip
}
