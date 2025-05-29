#!/bin/sh

cd /
[ ! -d /www/tinyfm/rootfs ] && ln -s / /www/tinyfm/rootfs
if [ -d /etc/openclash ]; then
    [ ! -e /www/tinyfm/openclash ] && ln -s /etc/openclash /www/tinyfm/openclash
fi
exit 0
