# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO:
# - Add USE="python", which pulls in this changes:
#	- build also python version of phantomjs (see python/README)
#	- add GPL-3 license
#	- Create a desktop file for PyPhantomJS

EAPI=3

inherit eutils qt4-r2

DESCRIPTION="PhantomJS is a headless WebKit with JavaScript API."
HOMEPAGE="http://phantomjs.org"
SRC_URI="http://${PN}.googlecode.com/files/${P}-source.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=x11-libs/qt-core-4.7.2
	>=x11-libs/qt-webkit-4.7.2
"
RDEPEND="${DEPEND}"

src_compile() {
	qt4-r2_src_compile
}

src_install() {
	cd "${S}"
	dodoc README.md ChangeLog
	dohtml examples/*
	dobin bin/"${PN}"
}
