# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

ECVS_SERVER="qgo.cvs.sourceforge.net:/cvsroot/qgo"
ECVS_MODULE="qgo2"

inherit games cvs qt4-r2 eutils

DESCRIPTION="qGo is a full featured SGF editor and Go Client."
HOMEPAGE="http://qgo.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	cvs_src_unpack
}

src_prepare() {
	epatch ${FILESDIR}/qgo2.patch
}

src_configure() {
	eqmake4 qgo2.pro
}

src_install() {
	qt4-r2_src_install

	dodoc AUTHORS

	insinto "${GAMES_DATADIR}"/qgo/languages
	doins src/translations/*.qm || die
}

