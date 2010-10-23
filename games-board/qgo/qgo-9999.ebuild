# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games cvs qt4-r2 eutils

DESCRIPTION="An ancient boardgame, very common in Japan, China and Korea"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI=""

ECVS_AUTH="pserver"
ECVS_MODULE="qgo2"
ECVS_SERVER="qgo.cvs.sourceforge.net:/cvsroot/qgo"
ECVS_USER="anonymous"
ECVS_LOCALNAME="qgo2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="media-libs/alsa-lib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4"

src_prepare() {
	sed -i \
		-e "/QGO_INSTALL_PATH/s:/usr/share:${GAMES_DATADIR}:" \
		-e "/QGO_INSTALL_BIN_PATH/s:/usr/bin:${GAMES_BINDIR}:" \
		-e 's:$(QTDIR)/bin/lrelease:lrelease:' \
		src/src.pro || die

	sed -i \
		-e "/TRANSLATIONS_PATH_PREFIX/s:/usr/share:${GAMES_DATADIR}:" \
		src/defines.h || die
}

src_configure() {
	eqmake4 qgo2.pro
}

src_install() {
	qt4-r2_src_install

	dodoc AUTHORS

	insinto "${GAMES_DATADIR}"/qgo/languages
	doins src/translations/*.qm || die

	prepgamesdir
}

