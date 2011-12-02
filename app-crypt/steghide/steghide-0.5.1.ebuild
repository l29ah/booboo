# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/steghide/Attic/steghide-0.5.1.ebuild,v 1.16 2011/08/01 18:53:13 hwoarang dead $

EAPI="3"
inherit autotools eutils

DESCRIPTION="A steganography program which hides data in various media files"
HOMEPAGE="http://steghide.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="debug"

DEPEND=">=app-crypt/mhash-0.8.18-r1
	>=dev-libs/libmcrypt-2.5.7
	>=sys-libs/zlib-1.1.4-r2
	virtual/jpeg"
RDEPEND="${DEPEND}"

src_prepare(){
	export CXXFLAGS="$CXXFLAGS -std=c++0x"
	epatch "${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_configure() {
	export CXXFLAGS="$CXXFLAGS -std=c++0x"
	econf $(use_enable debug)
}

src_compile() {
	export CXXFLAGS="$CXXFLAGS -std=c++0x"
	local libtool
	[[ ${CHOST} == *-darwin* ]] && libtool=$(type -P glibtool) || libtool=$(type -P libtool)
	emake LIBTOOL="${libtool}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}/usr/share/doc/${PF}" install || die "emake install failed"
	prepalldocs
}
