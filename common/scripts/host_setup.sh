#!/bin/sh -xe

yum -y install qemu-kvm libvirt virt-install bridge-utils
echo "options kvm-intel nested=1" > /etc/modprobe.d/kvm-nested.conf
