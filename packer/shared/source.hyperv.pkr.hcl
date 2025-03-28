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
  #ssh_timeout                       = "15m"

  iso_url                           = var.arch-bridge_iso-url
  iso_checksum                      = var.arch-bridge_iso-hash

  cd_label                          = "cidata"
  cd_files                          = ["scripts/meta-data"]
  cd_content                        = {
                                        "user-data" = templatefile("../../scripts/user-data.pkrtpl.hcl", {sshpub = data.sshkey.temp.public_key})
                                      }

  boot_wait                         = "3s"
  boot_command                      = [
                                        "e<end><spacebar>",
                                        "cow_spacesize=${var.arch-bridge_cow-size}M<spacebar>",
                                        "mirror=${var.arch-bridge_mirror}<spacebar>",
                                        "ds=nocloud<spacebar>",
                                        "network-config=disabled<enter>"
                                      ]

  shutdown_command                  = "shutdown -h now"
  disable_shutdown                  = true
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