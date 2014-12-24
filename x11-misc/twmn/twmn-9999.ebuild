# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2 git-r3

DESCRIPTION="A notification system for tiling window managers."
HOMEPAGE="https://github.com/sboli/Twmn"
EGIT_REPO_URI="https://github.com/sboli/twmn.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+qt5"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
	)
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtdbus:4
	)
	dev-libs/boost
	sys-apps/dbus
	"
RDEPEND="${DEPEND}"

DOCS=( TODO README.markdown )

src_unpack() {
	use qt5 || EGIT_COMMIT=e8f5096932db1fa1d7fcd7b2e421033cdfd52dac
	git-r3_src_unpack
}

src_prepare() {
	sed -i -e 's#/usr/local/#/usr/#g' */*.pro
}
