# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Critcl lets you easily embed C code in Tcl."
HOMEPAGE="http://github.com/andreas-kupries/critcl"
SRC_URI="http://github.com/andreas-kupries/critcl/tarball/${PV} -> ${P}.tar.gz"
S="${WORKDIR}/andreas-kupries-critcl-254bdff"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	./build.tcl install --prefix "${D}/usr"
}
