data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_iam_instance_profile" "grafana" {
  name = "<your-name>-grafana"
  # Sainsburys' Account/roles/ssm-ec2-role - contains: AmazonSSMManagedInstanceCore
  role = "ssm-ec2-role"
}

resource "aws_instance" "grafana" {
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = "t2.micro"
  user_data            = file("./templates/grafana/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.grafana.name
  # AcademySharedInfraStack/SainsburysSharedVpc/publicSubnet1
  subnet_id = "subnet-0d4860b711cb576a7"

  vpc_security_group_ids = [
    aws_security_group.grafana.id
  ]

  tags = merge(
    tomap({ "Name" = "<your-name>-grafana" })
  )
}

resource "aws_security_group" "grafana" {
  description = "Control grafana inbound and outbound access"
  name        = "<your-name>-grafana"
  # AcademySharedInfraStack/SainsburysSharedVpc
  vpc_id = "vpc-0e296a5c8aac14d8c"

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
      # AcademySharedInfraStack/SainsburysSharedVpc/privateSubnet1 CIDR
      "10.0.12.0/22",
      # AcademySharedInfraStack/SainsburysSharedVpc/privateSubnet2 CIDR
      "10.0.16.0/22",
    ]
  }
}
