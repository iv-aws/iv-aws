resource "aws_vpc" "ivy_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ec2_subnet" {
  vpc_id = aws_vpc.ivy_vpc.id
  cidr_block = "10.0.8.0/24"
}

resource "aws_subnet" "lambda_subnet" {
  vpc_id = aws_vpc.ivy_vpc.id
  cidr_block = "10.0.9.0/24"
}

resource "aws_subnet" "vpn_subnet" {
  vpc_id = aws_vpc.ivy_vpc.id
  cidr_block = "10.0.10.0/24"
}

resource "aws_security_group" "lambda_http" {
  vpc_id = aws_vpc.ivy_vpc.id
  name = "lambda-sg"
}

resource "aws_security_group_rule" "lambda_http_rule" {
    type = "ingress"
    security_group_id = aws_security_group.lambda_http.id
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "TCP"
    to_port = "80"
    from_port = "80"
}

resource "aws_security_group_rule" "lambda_https_rule" {
    type = "ingress"
    security_group_id = aws_security_group.lambda_http.id
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "TCP"
    to_port = "443"
    from_port = "443"
}

resource "aws_security_group_rule" "lambda_http_dev_rule" {
    type = "ingress"
    security_group_id = aws_security_group.lambda_http.id
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "TCP"
    to_port = "8000"
    from_port = "8000"
}