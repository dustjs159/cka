build {
  name = "cka-practice-ami-ubuntu-build"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}
