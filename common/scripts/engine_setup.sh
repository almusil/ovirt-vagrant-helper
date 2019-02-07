#!/bin/sh -xe

ANSWER_LOCATION="/tmp/answer.conf"

yum -y install ovirt-engine

engine-setup --config-append=${ANSWER_LOCATION} --accept-defaults

cat << EOF > /etc/ovirt-engine/engine.conf.d/11-disable_sso.conf
SSO_CALLBACK_PREFIX_CHECK=false
EOF

systemctl restart ovirt-engine
