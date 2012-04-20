# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

DESCRIPTION="Rectangle monochrome tileset for Freeciv"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="http://download.gna.org/freeciv/contrib/tilesets/chess/chess-v2.0.tar.bz2"

LICENSE="GPL2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=games-strategy/freeciv-2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	S=`pwd`
}

src_install() {
	dodir /usr/share/games/freeciv
	insinto /usr/share/games/freeciv
	doins chess.tilespec

	dodir /usr/share/games/freeciv/chess
	insinto /usr/share/games/freeciv/chess
	doins chess/*.png
	doins chess/*.spec
	doins chess/*.tilespec

	dodoc chess/chess.README
	dodoc chess/COPYING
}

