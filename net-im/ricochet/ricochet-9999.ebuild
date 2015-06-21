# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 qmake-utils

DESCRIPTION="Anonymous metadata-resistant instant messaging that just works"
HOMEPAGE="https://github.com/ricochet-im/ricochet"
EGIT_REPO_URI="https://github.com/ricochet-im/ricochet"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="debug"

cDEPEND="
	dev-libs/openssl
	dev-libs/protobuf
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/linguist-tools:5
	"
DEPEND="${cDEPEND}
	virtual/pkgconfig"
RDEPEND="${cDEPEND}
	net-misc/tor"

src_configure() {
	use debug && d='CONFIG+=debug' || d='CONFIG+=release'
	eqmake5 DEFINES+=RICOCHET_NO_PORTABLE $d
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
}
