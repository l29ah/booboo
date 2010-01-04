# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.14-r1.ebuild,v 1.22 2009/03/29 00:05:53 solar Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Library for overlaying text in X-Windows X-On-Screen-Display plus binary for sending text from CLI"
HOMEPAGE="https://sourceforge.net/projects/libxosd/"
SRC_URI="mirror://debian/pool/main/x/xosd/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/xosd/${PN}_${PV}-1.diff.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-gentoo-m4-1.tar.bz2
	xft? (
	http://sites.google.com/site/bb1001dd/linux-hacks-and-patches/xosd-font-antialiasing-patch/xosd-2.2.14-xft.patch
	-> xosd-2.2.14-xft.patch )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="xinerama xft"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	xft? ( x11-libs/pango )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xextproto
	x11-proto/xproto
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${DISTDIR}"/${PN}_${PV}-1.diff.gz
	use xft && epatch "${DISTDIR}"/xosd-2.2.14-xft.patch

	#AT_M4DIR="${WORKDIR}/m4" eautoreconf
}

src_compile() {
	econf \
		$(use_enable xinerama)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
