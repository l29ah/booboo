# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games subversion qt4-r2 eutils

ESVN_REPO_URI="https://qgo.svn.sourceforge.net/svnroot/qgo/trunk"

DESCRIPTION="qGo is a full featured SGF editor and Go Client."
HOMEPAGE="http://qgo.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qttest:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/qgo2.patch" )

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	eqmake4 qgo.pro
}

src_install() {
	qt4-r2_src_install

	dodoc AUTHORS

	insinto "${GAMES_DATADIR}"/qgo/languages
	doins src/translations/*.qm || die
}

