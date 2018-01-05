# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="Full-featured user interface for Machinekit"
HOMEPAGE="https://github.com/qtquickvcp/Cetus"
EGIT_REPO_URI=https://github.com/qtquickvcp/Cetus

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtquickcontrols:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	net-misc/QtQuickVcp
"


src_prepare() {
	S="${WORKDIR}/${P}/build"
	mkdir "$S"
}

src_configure() {
	eqmake5 ../${PN}.pro
}

src_install() {
	dobin Cetus
}
