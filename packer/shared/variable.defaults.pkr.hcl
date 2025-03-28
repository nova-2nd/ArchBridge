variable arch-bridge_iso-url {
  type    = string
  default = "http://ftp.cc.uoc.gr/mirrors/linux/archlinux/iso/latest/archlinux-x86_64.iso"
  #default = "http://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso"
}

variable arch-bridge_iso-hash {
  type    = string
  default = "file:https://ftp.cc.uoc.gr/mirrors/linux/archlinux/iso/latest/sha256sums.txt"
  #default = "file:https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt"
}

variable arch-bridge_mirror {
  type    = string
  default = "http://ftp.cc.uoc.gr/mirrors/linux/archlinux/"
}

variable arch-bridge_cow-size {
  type    = number
  default = 2048
}

variable "build_slug" {
  type    = list(string)
  default = ["debian-12"]
  validation {
    condition = alltrue(
      [for slug in var.build_slug :
        contains(
          [
            "debian-12",
            "debian-13",
            "ubuntu-2004"
          ], slug
        )
      ]
    )
    error_message = "Not supported OS slug provided."
  }
}

variable "artifacts_root" {
  type    = string
  default = "packer/artifacts"
}

variable "artifacts_packer" {
  type    = string
  default = "packer/artifacts/packer"
}

variable "artifacts_vagrant" {
  type    = string
  default = "packer/artifacts/vagrant"
}

variable "http_proxy" {
  type    = string
  default = ""
}