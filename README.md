Welcome to the Arch Bridge project

The main purpose of this project is to install a multitude of operating without an installer and the resulting problems and shortcomings (preseed, kickstart, simple storage stack).

This is achieved via the "original" installation method based on chroot before there were installers.

The whole process from storage configuration, package installation and configuration, usually carried out by an installer, is done by ansible.

The arch installation ISO had been choosen because of it's general versatility, availability of the most important package managers like apt and yum and arch's default installation method based on chroot too

The image generation is done by packer, the resulting images are kept with a minimum footprint as far as possible. Exceptions to this are,
- python, as a base for ansible
- cloud-init, for offline initialization

Boot process:
- Phase 1: Boot the media
- Phase 2: Establish SSH
- Phase 3: Enable Ansible
- Phase 4: Provision with ansible

Operating Systems:
- Debian's (and it's descendants) bootstrapping is based on apt, there is a convenience wrapper script called debootstrap, which is also used by the debian installer

Further documentation can be found in the docs directory
