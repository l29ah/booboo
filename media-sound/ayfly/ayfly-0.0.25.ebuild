# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils

DESCRIPTION="Ayfly is a AY-891x emulator and player."
HOMEPAGE="http://code.google.com/p/ayfly/"
SRC_URI="http://ayfly.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="wxwidgets"

RDEPEND="wxwidgets? ( x11-libs/wxGTK )"
DEPEND="$RDEPEND
	media-libs/libsdl"


src_prepare() {
	use arm && epatch ${FILESDIR}/disable_filters.patch
}

src_configure() {
	local myconf
	use wxwidgets || myconf+=" --without-gui"
	econf $myconf
}

src_install() {
	einstall
}
