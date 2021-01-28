# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit subversion eutils qmake-utils xdg-utils

ESVN_REPO_URI="https://svn.code.sf.net/p/qgo/code/trunk"

DESCRIPTION="qGo is a full featured SGF editor and Go Client."
HOMEPAGE="http://qgo.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qttest:5"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/qgo2.patch" )

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	eqmake5 qgo.pro
}

src_install() {
	INSTALL_ROOT="${D}" emake install || di

	dodoc AUTHORS || die

	insinto /usr/share/qgo/languages
	doins src/translations/*.qm || die
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

