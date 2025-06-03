source "amazon-ebs" "ubuntu" {
  ami_name      = "cka-practice-ami-ubuntu"
  ssh_username  = "ubuntu"
  instance_type = "t3.micro"
  region        = "ap-northeast-2"
  subnet_id     = "subnet-038f51c65947af7ec"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_type           = "gp3"
    volume_size           = 20 # 원하는 크기 (GiB)
    delete_on_termination = true
  }
}
