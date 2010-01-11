# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4

DESCRIPTION="Simple program which makes everything well"
HOMEPAGE="http://www.qt-apps.org/content/show.php/Zaebis?content=102362"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/102362-good.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpack ${A}
}

src_configure() {
	eqmake4 good.pro
}
src_install() {
	exeinto /usr/bin
	doexe good
}
