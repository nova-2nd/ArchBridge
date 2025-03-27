source "hyperv-iso" "arch" {
  #vm_name                           = "Arch-Bridge"
  generation                        = 2
  enable_secure_boot                = false
  secure_boot_template              = "MicrosoftUEFICertificateAuthority"
  switch_name                       = "Default Switch"
  enable_mac_spoofing               = true
  cpus                              = 4
  enable_virtualization_extensions  = true
  memory                            = 8192
  enable_dynamic_memory             = false
  disk_size                         = 20480

  ssh_username                      = "root"
  ssh_private_key_file              = data.sshkey.temp.private_key_path

  iso_url                           = var.arch-bridge_iso-url
  iso_checksum                      = var.arch-bridge_iso-hash

  boot_wait                         = "3s"
  boot_command                      = [
                                        # Boot phase 1
                                        "e<end><spacebar>cow_spacesize=${var.arch-bridge_cow-size}M<spacebar>mirror=${var.arch-bridge_mirror}<enter><wait15s>",
                                        # Boot phase 2
                                        "echo ${data.sshkey.temp.public_key} > /root/.ssh/authorized_keys<enter>",
                                        "systemctl start sshd<enter>",
                                        "top<enter>"
                                      ]

  shutdown_command                  = "shutdown -h now"
  #disable_shutdown                  = true
  shutdown_timeout                  = "15m"
}

source "hyperv-vmcx" "arch" {
  generation                        = 2
  enable_secure_boot                = false
  secure_boot_template              = "MicrosoftUEFICertificateAuthority"
  switch_name                       = "Default Switch"
  enable_mac_spoofing               = true
  cpus                              = 4
  enable_virtualization_extensions  = true
  memory                            = 8192
  enable_dynamic_memory             = false
  disk_size                         = 20480

  ssh_username                      = "vagrant"
  ssh_private_key_file              = "ansible/files/vagrant.key.ed25519"

  clone_from_vmcx_path              = ".packer/artifacts/debian-12/Virtual Machines"

  shutdown_command                  = "shutdown -h now"
  #disable_shutdown                  = true
  shutdown_timeout                  = "15m"
}