variable "access_key" {}
variable "secret_key" {}
variable "envirnonment" {}
variable "cidr_block" {}

provider "aws" {
    region = "eu-west-2"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_block [0]
    tags = {
      Name: var.envirnonment
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_block [1]  
}

data "aws_vpc" "default-vpc" {
    default = true
}
resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.default-vpc.id
    cidr_block = var.cidr_block [2]
    availability_zone = "eu-west-2a"  
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}
