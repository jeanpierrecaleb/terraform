#create and verify the variable

variable "my_vpc_id" {
  type        = string
  description = "my vpc id"
}

/* variable "subnet-cidr_block" {
  type        = string
  description = "Range IP address of the subnet"
} */

/* variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
} */

/* variable "nbr_pub-sub" {
  type = number
} */

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-north-1a", "eu-north-1b"]
}

variable "public_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}




/* variable "instance_name" {
  type        = string
  description = "tag for name"

}*/


