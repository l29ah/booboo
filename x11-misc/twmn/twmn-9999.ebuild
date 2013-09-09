# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2 git-2

DESCRIPTION="A notification system for tiling window managers."
HOMEPAGE="https://github.com/sboli/Twmn"
EGIT_REPO_URI="https://github.com/sboli/twmn.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:4
	dev-libs/boost
	sys-apps/dbus
	"
RDEPEND="${DEPEND}"

DOCS=( TODO README.markdown )

src_prepare() {
	sed -i -e 's#/usr/local/#/usr/#g' */*.pro
}
