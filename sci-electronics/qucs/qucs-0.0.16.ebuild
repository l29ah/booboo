# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="Quite Universal Circuit Simulator is a Qt based circuit simulator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://qucs.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-meta:3"
RDEPEND="x11-libs/qt-meta:3
	>=sci-electronics/freehdl-0.0.7"

src_configure() {
	econf --with-x $(use_enable debug)
}

src_install() {
	emake install DESTDIR="${D}" || die

	newicon qucs/bitmaps/big.qucs.xpm qucs.xpm || die
	make_desktop_entry qucs Qucs qucs "Qt;Science;Electronics"
}
