include $(TOPDIR)/rules.mk

PKG_NAME:=sing-box
PKG_VERSION:=1.12.0-beta.19
PKG_RELEASE:=

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/SagerNet/sing-box/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=f56a43aa496a2c92f1e79996c2a2300dc648216a746809fb81aac7a65f8a21f3

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=JJ

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/sagernet/sing-box
GO_PKG_BUILD_PKG:=$(GO_PKG)/cmd/sing-box

GO_PKG_LDFLAGS_X:=$(GO_PKG)/constant.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/sing-box
  TITLE:=The universal proxy platform
  SECTION:=net
  CATEGORY:=Network
  URL:=https://sing-box.sagernet.org
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle +kmod-inet-diag +kmod-tun
  USERID:=sing-box=5566:sing-box=5566
endef

define Package/sing-box/description
  Sing-box is a universal proxy platform which supports hysteria, SOCKS, Shadowsocks,
  ShadowTLS, Tor, trojan, VLess, VMess, WireGuard and so on.
endef

define Package/sing-box/config
	menu "Select build options"
		depends on PACKAGE_sing-box

		config SINGBOX_WITH_ACME
			bool "Build with ACME TLS certificate issuer support"
			default y

		config SINGBOX_WITH_CLASH_API
			bool "Build with Clash API support"
			default y

		config SINGBOX_WITH_DHCP
			bool "Build with DHCP support, see DHCP DNS transport."
			default y

		config SINGBOX_WITH_GRPC
			bool "Build with standard gRPC support"

		config SINGBOX_WITH_GVISOR
			bool "Build with gVisor support"
			default y

		config SINGBOX_WITH_QUIC
			bool "Build with QUIC support"
			default y

		config SINGBOX_WITH_TAILSCALE
			bool "Build with TAILSCALE extension support"
			default y

		config SINGBOX_WITH_UTLS
			bool "Build with uTLS support for TLS outbound"
			default y

		config SINGBOX_WITH_V2RAY_API
			bool "Build with V2Ray API support"

		config SINGBOX_WITH_WIREGUARD
			bool "Build with WireGuard support"
			default y
	endmenu
endef

PKG_CONFIG_DEPENDS:= \
	CONFIG_SINGBOX_WITH_ACME \
	CONFIG_SINGBOX_WITH_CLASH_API \
	CONFIG_SINGBOX_WITH_DHCP \
	CONFIG_SINGBOX_WITH_GVISOR \
	CONFIG_SINGBOX_WITH_QUIC \
	CONFIG_SINGBOX_WITH_TAILSCALE \
	CONFIG_SINGBOX_WITH_UTLS \
	CONFIG_SINGBOX_WITH_WIREGUARD

GO_PKG_TAGS:=$(subst $(space),$(comma),$(strip \
	$(if $(CONFIG_SINGBOX_WITH_ACME),with_acme) \
	$(if $(CONFIG_SINGBOX_WITH_CLASH_API),with_clash_api) \
	$(if $(CONFIG_SINGBOX_WITH_DHCP),with_dhcp) \
	$(if $(CONFIG_SINGBOX_WITH_GVISOR),with_gvisor) \
	$(if $(CONFIG_SINGBOX_WITH_QUIC),with_quic) \
	$(if $(CONFIG_SINGBOX_WITH_TAILSCALE),with_tailscale) \
	$(if $(CONFIG_SINGBOX_WITH_UTLS),with_utls) \
	$(if $(CONFIG_SINGBOX_WITH_WIREGUARD),with_wireguard) \
))

define Package/$(PKG_NAME)/conffiles
endef

define Package/$(PKG_NAME)/install
	$(call GoPackage/Package/Install/Bin,$(1))
endef

$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
