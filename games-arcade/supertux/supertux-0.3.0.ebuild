# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild come from http://bugs.gentoo.org/show_bug.cgi?id=158582 - The site http://gentoo.zugaina.org/ only host a copy.

inherit eutils games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="http://download.berlios.de/supertux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.2
	sys-libs/zlib
	dev-util/ftjam
	>=dev-games/physfs-1.0.0
	media-libs/libvorbis
	media-libs/libogg
	media-libs/openal"
DEPEND="${RDEPEND}
	x11-libs/libXt"

pkg_setup() {
	games_pkg_setup
}

src_compile() {
	egamesconf \
		--disable-debug \
		|| die
	jam || die "jam failed"
}

src_install() {
	DESTDIR=${D} jam \
		install || die "jam install failed"
	dodoc README 
	prepgamesdirs
}
