source "hyperv-iso" "arch-bridge" {
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

  cd_label                          = "cidata"
  cd_files                          = ["packer/files/meta-data"]
  cd_content                        = {
                                        "user-data" = templatefile("../files/user-data.pkrtpl.hcl", {sshpub = data.sshkey.temp.public_key})
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
  shutdown_timeout                  = "15m"
  #disable_shutdown                  = true
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

  ssh_username                      = "root"
  ssh_private_key_file              = data.sshkey.temp.private_key_path

  clone_from_vmcx_path              = ".packer/artifacts/debian-12/Virtual Machines"

  cd_label                          = "cidata"
  cd_files                          = ["packer/files/meta-data"]
  cd_content                        = {
                                        "user-data" = templatefile("../files/user-data.pkrtpl.hcl", {sshpub = data.sshkey.temp.public_key})
                                      }

  shutdown_command                  = "shutdown -h now"
  shutdown_timeout                  = "15m"
  #disable_shutdown                  = true
}