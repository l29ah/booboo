# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 qmake-utils

DESCRIPTION="A simple QML GUI to use with oFono"
HOMEPAGE="https://github.com/matgnt/mobos-gui"
EGIT_REPO_URI="https://github.com/matgnt/mobos-gui"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtgui:4
	dev-qt/qtdbus:4
	dev-qt/qtdeclarative:4
	dev-qt/qtcore:4"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 PREFIX="${D}"/usr
}
