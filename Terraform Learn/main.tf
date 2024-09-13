
# Create an EC2 instance using existing resources
resource "aws_instance" "tackie_test_server" {
  ami                 = "ami-0182f373e66f89c85"
  instance_type       = "t2.micro"
  key_name            = "tackiec7key"

  # Specify the availability zone
  availability_zone = "us-east-1c"

  tags = {
    Name = "Mytestserver"
  }

}

# Create an EBS volume
resource "aws_ebs_volume" "tackie_c7_ebs" {
  availability_zone = "us-east-1c"
  size              = 8     # Size in GB
  type              = "gp3" # General Purpose SSD

  tags = {
    Name = "tackie_ebs_volume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "attach_ebs_volume" {
  device_name = "/dev/sdf" # Linux device name (could be /dev/xvdf or similar)
  volume_id   = aws_ebs_volume.tackie_c7_ebs.id
  instance_id = aws_instance.tackie_test_server.id
}