build {
  name = "arch-bridge"
  dynamic "source" {
    labels                        = ["source.hyperv-iso.arch"]
    for_each                      = var.build_slug
    content {         
      name                        = source.value
      vm_name                     = source.value
      output_directory            = ".packer/artifacts/${source.value}/"
    }
  }

  provisioner "shell" {
    # Boot phase 3
    script                        = "scripts/arch-bridge_phase3.sh"
    environment_vars              = ["http_proxy=${var.http_proxy}"]
  }

  provisioner "ansible-local" {
    # Boot phase 4
    playbook_file                 = "ansible/playbook_debian_on_arch.yml"
    playbook_dir                  = "ansible"
    extra_arguments               = [
                                      "-vvv",
                                      "-e http_proxy=${var.http_proxy}"
                                    ]
  }

  post-processor "manifest" {
    output                        = ".packer/artifacts/vagrant/packer_${source.name}-manifest.json"
  }

  post-processor "vagrant" {
    keep_input_artifact           = true
    output                        = ".packer/artifacts/vagrant/packer_${source.name}.box"
  }
}
