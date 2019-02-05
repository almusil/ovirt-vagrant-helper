#/bin/sh -xe

DATA_FOLDER="/exports/data"
ISO_FOLDER="/exports/iso"
EXPORT_FOLDER="/exports/export"

echo "$DATA_FOLDER *(rw)" >> /etc/exports
echo "$ISO_FOLDER *(rw)" >> /etc/exports
echo "$EXPORT_FOLDER *(rw)" >> /etc/exports

yum -y install nfs-utils
systemctl daemon-reload
systemctl enable rpcbind.service
systemctl enable nfs-server.service
systemctl start rpcbind.service
systemctl start nfs-server.service
mkdir -p ${DATA_FOLDER}
mkdir -p ${EXPORT_FOLDER}
mkdir -p ${ISO_FOLDER}
useradd vdsm -u 36 -g 36
chown -R 36:36 ${ISO_FOLDER}
chown -R 36:36 ${EXPORT_FOLDER}
chown -R 36:36 ${DATA_FOLDER}
chmod 0755 ${DATA_FOLDER}
chmod 0755 ${EXPORT_FOLDER}
chmod 0755 ${ISO_FOLDER}
exportfs -r
systemctl restart nfs-server.service
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=nfs
firewall-cmd --reload
