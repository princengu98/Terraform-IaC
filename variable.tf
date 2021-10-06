variable "aws_region" {}
variable "vpc_cidr_block" {
    description = "Cidr block for the vpc"
}
variable "subnet_cidr_block" {
    description = "Cidr for public and private subnets"
    type = list(object({
        subnet_cidr_block = string
        name = string
    }))
}
variable "AZ" {
    description = "Availability zones for the subnets"
    type = list(object({
        AZ = string
        name = string
    }))
}
variable "env_prefix" {}
variable "my-ip" {}
variable "instance_type" {}
variable "public_key-pair" {}
variable "private_key_pair" {}
