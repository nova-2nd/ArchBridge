#cloud-config

cloud_init_modules: ["ssh"]

cloud_config_modules: []

cloud_final_modules: []

users: []
ssh_quiet_keygen: true
disable_root: false
ssh_genkeytypes: ["ed25519"]
disable_root_opts: ""
ssh_authorized_keys: 
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOD+Wth7Qd6AtRCXOxhgKrXDqiu/1L2biYVzY1zLtXi1 stefan@nader.zone
  - ${sshpub}
