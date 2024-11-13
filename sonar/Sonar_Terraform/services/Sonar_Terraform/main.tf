data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

// Using AWS EC2 module to create instance
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = var.InstanceName
  instance_count         = 1

  ami                    = var.amiID
  instance_type          = var.instanceType
  key_name               = "Jenkins"
  monitoring             = true
  vpc_security_group_ids = [module.security_group.this_security_group_id]
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]


  tags = {
    Terraform   = "true"
    Environment = var.envName
  }


}


// Using AWS SG_Module to create security group

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = var.securityName
  description = var.securityDescription
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

//Creating Volume to mount on the AWS instance

resource "aws_ebs_volume" "this"{
  availability_zone = module.ec2_cluster.availability_zone[0]
  size = 40
  tags = {
    Name=var.InstanceName
  }
}

// Mounting volume on AWS instance

resource "aws_volume_attachment" "this_ec2" {
  device_name = "/dev/sdf"
  instance_id = module.ec2_cluster.id[0]
  volume_id = aws_ebs_volume.this.id
}

// Backend configuration for storing terraform state file

terraform {
  backend "s3" {
    bucket = "hclawspib-terraform-state-file"
    key = "sonar"
    region = "ap-south-1"
    dynamodb_table = "pib-locks-for-state"
    encrypt        = true
  }
}

/*resource "null_resource" "copy_inventory" {
  provisioner "local-exec" {
    command = "echo ${ module.ec2_cluster.public_ip} >> private_ips.txt"
  }
}*/






