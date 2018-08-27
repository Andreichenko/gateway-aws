variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "aleksKeys"
}

variable "network_address_space" {
  default = "172.13.2.0/16"
}

variable "subnet1_address_space" {
  default = "172.13.2.0/24"
}

variable "subnet2_address_space" {
  default = "172.13.3.0/24"
}

provider "aws" {
  region = "us-west-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_availability_zones" "avaliable" {}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.network_address_space}}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "subnet1" {
  cidr_block = "${var.subnet1_address_space}}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.avaliable.names[0]}}"
}

resource "aws_subnet" "subnet2" {
  cidr_block = "${var.subnet2_address_space}}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.avaliable.names[1]}"
}

resource "aws_route_table" "rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}}"
  }
}

resource "aws_route_table_association" "rta_subnet1" {
  route_table_id = "${aws_subnet.subnet1.id}}"
  subnet_id = "${aws_route_table.rtb.id}"
}



