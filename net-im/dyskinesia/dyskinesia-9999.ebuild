# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 git-r3

DESCRIPTION="A PSYC client written in QT"
HOMEPAGE="http://about.psyc.eu/Dyskinesia"
EGIT_REPO_URI="git://gitorious.org/qt-psyc-client/mainline.git"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4
	dev-qt/designer:4
	<net-libs/libotr-4.0.0"
DEPEND="${RDEPEND}"

src_configure() {
	qt4-r2_src_configure
	sed -i -e 's#^\(LIBS.*\)$#\1 -lX11#' Makefile
}

src_install() {
	dobin $PN
}
