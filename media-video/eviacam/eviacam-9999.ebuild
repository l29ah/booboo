# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="webcam based mouse emulator"
HOMEPAGE="https://github.com/cmauri/eviacam"
EGIT_REPO_URI="https://github.com/cmauri/eviacam"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	x11-libs/wxGTK:3.0
	media-libs/opencv
	x11-libs/libXtst
	x11-libs/libXext"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	# https://github.com/cmauri/eviacam/issues/14
	eapply "$FILESDIR/$PN-force-gtk2.patch"

	# see autogen.sh
	touch config.rpath
	eautoreconf
}

src_configure() {
	econf "--with-wx-config=wx-config --toolkit=gtk2"
}
