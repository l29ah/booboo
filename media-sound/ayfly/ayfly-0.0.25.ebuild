# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ayfly is a AY-891x emulator and player."
HOMEPAGE="http://code.google.com/p/ayfly/"
SRC_URI="http://ayfly.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/sdl-sound"
RDEPEND="media-libs/sdl-sound"

src_install() {
	einstall
}
