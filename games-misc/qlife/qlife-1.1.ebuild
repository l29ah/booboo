# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/qlife/qlife-0.9.ebuild,v 1.6 2008/08/14 17:18:48 nixnut Exp $

EAPI=1
inherit qt4 games

MY_P=${PN}-qt4-${PV}
DESCRIPTION="Simulates the classical Game of Life invented by John Conway"
HOMEPAGE="http://personal.inet.fi/koti/rkauppila/projects/life/"
SRC_URI="http://open-maker.tuxfamily.org/blog/public/qlife_linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="|| ( x11-libs/qt-gui:4 x11-libs/qt:4 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/setPath/s:patterns:${GAMES_DATADIR}/${PN}/patterns:" \
		lifedialog.cpp || die "sed failed"
}

src_compile() {
	eqmake4
	emake || die "emake failed"
}

src_install() {
	dogamesbin qlife || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins patterns/* || die "doins failed"
	dohtml *.html
	dodoc About README
	prepgamesdirs
}
