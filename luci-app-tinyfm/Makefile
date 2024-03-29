#
# Tiny File Manager by prasathmani <https://github.com/prasathmani/tinyfilemanager>
# LuCI Tiny File Manager App by Helmi Amirudin <https://www.helmiau.com>
#
# Copyright (C) 2021 Helmi Amirudin <https://www.helmiau.com>
# This is free software, licensed under the Apache License, Version 2.0
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Tiny File Manager App
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+php8 +php8-cgi +php8-mod-ctype +php8-mod-fileinfo +php8-mod-gettext +php8-mod-gmp +php8-mod-iconv +php8-mod-mbstring +php8-mod-pcntl +php8-mod-session +php8-mod-zip +php8-mod-filter +zoneinfo-asia

PKG_NAME:=luci-app-tinyfm
PKG_VERSION:=2.5.3
PKG_RELEASE:=2

define Package/$(PKG_NAME)
	$(call Package/luci/webtemplate)
	TITLE:=$(LUCI_TITLE)
	DEPENDS:=$(LUCI_DEPENDS)
endef

define Package/$(PKG_NAME)/description
	This is Tiny File Manager, but for LuCI OpenWrt.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
	chmod -R 755 /root/www/*
	chmod -R 755 /root/www/tinyfm/*
	chmod -R 755 /root/www/tinyfm/assets/*
	[ ! -d /root/www/tinyfm/rootfs ] && ln -s / /root/www/tinyfm/rootfs
	[ ! -d /www/tinyfm/openclash ] && ln -s /etc/openclash /www/tinyfm/openclash
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
	rm -f /tmp/luci-indexcache
	rm -f /tmp/luci-modulecache/*
	chmod -R 755 /usr/lib/lua/luci/controller/*
	chmod -R 755 /usr/lib/lua/luci/view/*
	chmod -R 755 /www/*
	chmod -R 755 /www/tinyfm/*
	chmod -R 755 /www/tinyfm/assets/*
	[ ! -d /www/tinyfm/rootfs ] && ln -s / /www/tinyfm/rootfs
	[ ! -d /www/tinyfm/openclash ] && ln -s /etc/openclash /www/tinyfm/openclash
	if ! grep -q ".php=/usr/bin/php8-cgi" /etc/config/uhttpd; then
		echo -e "  Log : system not using php-cgi, patching php config ..."
		logger "  Log : system not using php-cgi, patching php config..."
		uci set uhttpd.main.ubus_prefix='/ubus'
		uci set uhttpd.main.interpreter='.php=/usr/bin/php8-cgi'
		uci set uhttpd.main.index_page='cgi-bin/luci'
		uci commit uhttpd
		echo -e "  Log : patching system with php configuration done ..."
		echo -e "  Log : restarting some apps ..."
		logger "  Log : patching system with php configuration done..."
		logger "  Log : restarting some apps..."
		/etc/init.d/uhttpd restart
	fi
	[ -d /usr/lib/php8 ] && [ ! -d /usr/lib/php ] && ln -sf /usr/lib/php8 /usr/lib/php
exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
	[ -d /www/tinyfm ] && rm -rf /www/tinyfm
exit 0
endef

include $(TOPDIR)/feeds/luci/luci.mk

$(eval $(call BuildPackage,$(PKG_NAME)))
