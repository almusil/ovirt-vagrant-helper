#!/bin/sh -xe
export VDSM_SOURCE_DIR=/root/vdsm


yum -y install $(cat ${VDSM_SOURCE_DIR}/automation/check-patch.packages.el7)

source /root/vdsm/contrib/shell_helper
pip install --user tox
vdsm_build
vdsm_install
vdsm_restart
pip install pytest==3.9.3
systemctl enable openvswitch.service
systemctl start openvswitch.service
vdsm_restart

# pytest /usr/share/vdsm/tests/*
