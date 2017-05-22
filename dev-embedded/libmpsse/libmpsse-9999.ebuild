# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )

inherit eutils python-single-r1 git-r3 autotools

DESCRIPTION="Open source library for SPI/I2C control via FTDI chips"
HOMEPAGE="https://github.com/l29ah/libmpsse"
EGIT_REPO_URI="https://github.com/l29ah/libmpsse"

LICENSE="BSD-2"
SLOT="0"
IUSE="doc examples python"

RDEPEND="dev-embedded/libftdi:0"
DEPEND="dev-lang/swig
	${RDEPEND}"

S="${WORKDIR}/$P/src"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable python)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ../README
	dodoc ../docs/README*
	if use doc ; then
		dodoc ../docs/AN_135_MPSSE_Basics.pdf
	fi
	if use examples ; then
		insinto /usr/share/${PN}/
		doins -r examples
	fi
}
