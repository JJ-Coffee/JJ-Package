#!/bin/sh

cd /
[ ! -d /www/tinyfm/rootfs ] && ln -s / /www/tinyfm/rootfs
[ ! -d /www/tinyfm/openclash ] && ln -s /etc/openclash /www/tinyfm/openclash
exit 0
