data "external" "my_ip" {
  program = ["zsh", "scripts/myip.sh"]
}