# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-2.0-r1.ebuild,v 1.3 2007/04/16 07:34:47 corsair Exp $

inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${P%%_*}"
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.kdown1.de/files/${MY_P}-src.tgz"
HOMEPAGE="http://www.klografx.net/qiv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE="xinerama"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=media-libs/imlib-1.9.10
	|| (
	( >=x11-libs/libX11-1.0.0
	>=x11-proto/xineramaproto-1.1.2 )
	virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-composite.patch
}

src_compile() {
	use xinerama && sed -i "s:# GTD_XINERAMA = -DGTD_XINERAMA:GTD_XINERAMA = -DGTD_XINERAMA:" Makefile
	emake || die
}

src_install () {
	into /usr
	dobin qiv
	doman qiv.1
	dodoc README{,.TODO,.CHANGES}
}
