data "sshkey" "temp" {
  type = "ed25519"
}

locals {
  ssh_pub_key       = data.sshkey.temp.public_key
  ssh_priv_key_path = data.sshkey.temp.private_key_path
}
