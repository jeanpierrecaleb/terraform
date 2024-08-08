# Configure the cloud provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the files
provider "aws" {
  # authentifation files
  #shared_config_files      = ["C:/Users/tf_user/.aws/conf"]
  #shared_credentials_files = ["C:/Users/tf_user/.aws/creds"]
  shared_config_files      = ["/mnt/c/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/mnt/c/Users/tf_user/.aws/creds"]
  profile                  = "customprofile"
  # common configuration
  region                   = "eu-north-1"
}

# Configuring VPC - Virtual Private Network
# *-ressource *-resource_name_onaws *-variable
# variable miniscule and name (tag) with capital letter
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Main_vpc"
  }
}

/*resource "aws_key_pair" "my_key" {
  key_name   = "jenkins_kp"  # This should match the key pair name you created
  //public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file
}*/

module "subnet" {
  source = "./subnet"
  my_vpc_id = aws_vpc.main_vpc.id
  public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
// nbr_pub-sub = 2
// subnet-cidr_block = "10.0.1.0/24"
// subnet_name = "Subnet-01"
 
}

module "instances" {
  source = "./instances" 
  my_vpc_id = aws_vpc.main_vpc.id
  ec2_ami = "ami-07c8c1b18ca66bb07"
  my_instance_type = "t3.micro" 
  subnet-psids = module.subnet.subnet_ids // error
  my_key_name  = "jenkins_kp"
}

module "jenkins" {
  source = "./jenkins"
  j_ivpc = aws_vpc.main_vpc.id
  j_isubnet = module.subnet.subnet_ids[0]
  j_iname = "Jenkins_instance"
  j_isgp = module.instances.security_gp
  my_key_name  = "jenkins_kp"

}

output "ip_ad" {
  value = module.instances.ip_address
}

output "jenkins_ip" {
  value = format("Jenkins instance IP address %s", module.jenkins.j_ip_address)
}
