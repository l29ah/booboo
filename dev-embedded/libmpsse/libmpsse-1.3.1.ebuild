# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit eutils python-single-r1 autotools

DESCRIPTION="Open source library for SPI/I2C control via FTDI chips"
HOMEPAGE="https://github.com/l29ah/libmpsse"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/l29ah/libmpsse"
else
	SRC_URI="https://github.com/l29ah/libmpsse/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="doc examples python"

RDEPEND="dev-embedded/libftdi:0"
DEPEND="dev-lang/swig
	${RDEPEND}"

S="${WORKDIR}/$P/src"

src_prepare() {
	default

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
