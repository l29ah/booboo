# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdts/libdts-0.0.2-r3.ebuild,v 1.8 2005/11/25 00:59:37 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="library for decoding DTS Coherent Acoustics streams used in DVD"
HOMEPAGE="http://www.videolan.org/dtsdec.html"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="oss debug"
RESTRICT="test"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-devel/libtool
	=sys-devel/automake-1.7*
	>=sys-devel/autoconf-2.52d-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-libtool.patch"
	epatch "${FILESDIR}/${P}-freebsd.patch"

	eautoreconf
}

src_compile() {
	econf $(use_enable oss) $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO doc/libdts.txt
}

