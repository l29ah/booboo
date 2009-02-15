# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="High-level, UDP-based networking library"
HOMEPAGE="http://www.zoidcom.com/"
SRC_URI="http://www.zoidcom.com/download/${P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc sample"
# See README.TXT
RESTRICT="mirror"

RDEPEND=""
DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr
	doins -r include || die "doins include failed"
	dolib.so lib/linux/* || die "dolib failed"

	dodoc *.{txt,TXT}

	if use doc ; then
		insinto /usr/share/${PN}
		doins -r doc/* || die "doins doc failed"
	fi
	if use sample ; then
		insinto /usr/share/${PN}
		doins -r samples || die "doins samples failed"
	fi
}
