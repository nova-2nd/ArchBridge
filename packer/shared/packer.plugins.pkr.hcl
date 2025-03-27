packer {
  required_plugins {
    hyperv = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/hyperv"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
    sshkey = {
      version = ">= 1.1.0"
      source = "github.com/ivoronin/sshkey"
    }
  }
}