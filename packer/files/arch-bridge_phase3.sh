#!/bin/sh

#while :
#do 
#  if systemctl is-active pacman-init > /dev/null; then
#    echo Pacman-init successfull
#    break
#  else
#    echo Waiting for pacman-init
#  fi
#  sleep 1
#done

pacman-key --init
pacman-key --populate

pacman -Sy --needed archlinux-keyring --noconfirm
pacman -S --noconfirm ansible
