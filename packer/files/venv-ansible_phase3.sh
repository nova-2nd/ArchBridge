#!/bin/sh

apt-get install -y python3-venv python3-pip
python3 -m venv /opt/ansible
. /opt/ansible/bin/activate
pip install ansible
for i in $(ls -1 /opt/ansible/bin/ansible*); do
  ln -s "$i" /usr/bin/"${i##*/}"
done
deactivate
