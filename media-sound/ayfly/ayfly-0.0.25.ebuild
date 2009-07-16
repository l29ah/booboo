# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils
EAPI="2"
DESCRIPTION="Ayfly is a AY-891x emulator and player."
HOMEPAGE="http://code.google.com/p/ayfly/"
SRC_URI="http://ayfly.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND="media-libs/sdl-sound"
RDEPEND="media-libs/sdl-sound"

src_prepare() {
	use arm && epatch ${FILESDIR}/disable_filters.patch
}

src_install() {
	einstall
}
