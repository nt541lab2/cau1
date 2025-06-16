variable "aws_region" {
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ami_id" {
  default = "ami-0ba4a5d6a5a8f4661" # Ubuntu 22.04 LTS (ap-southeast-1)
}

variable "instance_type" {
  default = "t2.micro"
}
