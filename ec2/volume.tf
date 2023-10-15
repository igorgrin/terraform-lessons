resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.test_instance.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = module.test_instance.availability_zone
  size              = 5

  tags = {
    Name = "test"
  }
}
