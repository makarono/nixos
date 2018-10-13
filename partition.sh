#!/bin/bash
#https://nixos.org/nixos/manual/index.html#sec-installation

set -ex

#formatting
parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB -7GiB
parted /dev/sda -- mkpart primary linux-swap -1GiB 100%

#Commands for Installing NixOS on /dev/sda With a partitioned disk.
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
# mkfs.fat -F 32 -n boot /dev/sda3        # (for UEFI systems only)
mount /dev/disk/by-label/nixos /mnt
# mkdir -p /mnt/boot                      # (for UEFI systems only)
# mount /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
# nixos-install
# reboot