#!/bin/sh
BASEPATH=${BASEPATH:-/docker}
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
OWNER=${OWNER:-nobody}
GROUP=${GROUP:-nogroup}

cat <<EOF > /etc/rsyncd.conf
uid = ${OWNER}
gid = ${GROUP}
use chroot = yes
read only = true
pid file = /var/run/rsyncd.pid
log file = /dev/stdout
reverse lookup = no

EOF

for REPO in "$@"; do

cat <<EOF >> /etc/rsyncd.conf
[${REPO}]
    hosts deny = *
    hosts allow = ${ALLOW}
    path = ${BASEPATH}/${REPO}

EOF

chown "${OWNER}:${GROUP}" "${BASEPATH}/${REPO}"
done

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"
