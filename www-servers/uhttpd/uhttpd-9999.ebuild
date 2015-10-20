# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="OpenWRT HTTP server"
HOMEPAGE="http://wiki.openwrt.org/"
EGIT_REPO_URI="git://nbd.name/${PN}2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ssl lua ubus"

DEPEND="
	dev-libs/libubox
	lua? ( virtual/lua )
	ubus? ( sys-apps/ubus )
	ssl? ( net-libs/ustream-ssl )
"
RDEPEND="$DEPEND"

src_prepare() {
	sed -i 's/-Werror //' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DTLS_SUPPORT=$(usex ssl ON OFF)
		-DLUA_SUPPORT=$(usex lua ON OFF)
		-DUBUS_SUPPORT=$(usex ubus ON OFF)
	)

	cmake-utils_src_configure
}
