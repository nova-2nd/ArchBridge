build {
  dynamic "source" {
    labels                        = ["source.hyperv-vmcx.native"]
    for_each                      = var.build_slug
    content {         
      name                        = source.value
      vm_name                     = source.value
      output_directory            = "${var.artifacts_packer}/hyperv-kde/${source.value}/"
    }
  }

  provisioner "shell" {
    # Boot phase 3
    script                        = "packer/files/venv-ansible_phase3.sh"
    environment_vars              = ["http_proxy=${var.http_proxy}"]
  }

  provisioner "ansible-local" {
    # Boot phase 4
    playbook_file                 = "ansible/playbook_kde_on_debian.yml"
    playbook_dir                  = "ansible"
    extra_arguments               = [
                                      "-vvv",
                                      "-e http_proxy=${var.http_proxy}"
                                    ]
  }

  post-processor "manifest" {
    strip_path                    = true
    output                        = "${var.artifacts_packer}/hyperv-kde/${source.name}/manifest.json"
  }

  post-processor "vagrant" {
    keep_input_artifact           = true
    output                        = "${var.artifacts_vagrant}/hyperv-kde/${source.name}.box"
  }
}
