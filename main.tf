module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jazlyn-ec2-tf"

  instance_type = "t3.micro"
  key_name      = "jazlyn-keypair"
  monitoring    = true
  subnet_id     = "subnet-07fe08d5909e677db"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_ebs_volume" "ebs_launch" {
  availability_zone = module.ec2_instance.availability_zone # Replace with your desired Availability Zone
  size = 1            # Specify the size of the volume in GiB

  tags = {
    Name = "jazlyn-ebs" # Removed leading space for the volume name
  }
}

resource "aws_volume_attachment" "data" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_launch.id
  instance_id = module.ec2_instance.id
}