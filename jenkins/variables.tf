variable "j_itype" {
    type = string
    description = "ami of jenkins"
    default = "t3.micro"
  
}

variable "j_iami" {
  type = string
  description = "Jenkins ami"
  default = "ami-07c8c1b18ca66bb07" #ubuntu ami
  # amazon linux default = "ami-0d7e17c1a01e6fa40"
}

variable "j_iname" {
   type = string
  description = "Jenkins name"
  default = "Jenkins DevOps-01"
}

variable "j_ivpc" {
    type = string
    description = "Main VPC"
    # default = "value"
  
}

variable "j_isubnet" {
  type = string
  description = "Subnet of the the VPC"
}

variable "j_isgp" {
  type = list(string)
  description = "EC2 Sg to borrow"
}

variable "my_key_name" {
  type = string
  description = "Instances key pair"
}