# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="A general purpose library for the OpenWRT project."
HOMEPAGE="http://wiki.openwrt.org/"
EGIT_REPO_URI="git://nbd.name/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="polarssl cyassl +openssl"

DEPEND="
	dev-libs/libubox
	polarssl? ( net-libs/polarssl )
	cyassl? ( net-libs/cyassl )
	openssl? ( dev-libs/openssl )
"
RDEPEND="$DEPEND"

src_prepare() {
	sed -i 's/-Werror //' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DPOLARSSL=$(usex polarssl ON OFF)
		-DCYASSL=$(usex cyassl ON OFF)
	)

	cmake-utils_src_configure
}
