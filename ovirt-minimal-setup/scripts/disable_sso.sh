#!/bin/sh -xe

cat << EOF > /etc/ovirt-engine/engine.conf.d/11-disable_sso.conf
SSO_CALLBACK_PREFIX_CHECK=false
EOF

systemctl restart ovirt-engine
