# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/Attic/libusb-0.1.12-r7.ebuild,v 1.13 2013/08/01 12:27:35 ssuominen dead $

EAPI=6

inherit eutils libtool autotools toolchain-funcs multilib-minimal

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="debug doc +cxx static-libs"
RESTRICT="test"

RDEPEND="!dev-libs/libusb-compat"
DEPEND="${RDEPEND}
	doc? ( app-text/openjade
	app-text/docbook-dsssl-stylesheets
	app-text/docbook-sgml-utils
	~app-text/docbook-sgml-dtd-4.2 )"

src_prepare() {
	sed -i -e 's:-Werror::' Makefile.am
	sed -i 's:AC_LANG_CPLUSPLUS:AC_PROG_CXX:' configure.in #213800
	epatch "${FILESDIR}"/${PV}-fbsd.patch
	use cxx || epatch "${FILESDIR}"/${PN}-0.1.12-nocpp.patch
	epatch "${FILESDIR}"/${PN}-0.1.12-no-infinite-bulk.patch
	epatch "${FILESDIR}"/${PN}-0.1-ansi.patch # 273752
	epatch "$FILESDIR/08_bus_location.diff" # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=611958
	eautoreconf

	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debug all) \
		$(use_enable doc build-docs)
}

multilib_src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	gen_usr_ldscript -a usb
}

multilib_src_install_all() {
	dodoc AUTHORS NEWS README
	use doc && dohtml doc/html/*.html

	use cxx || rm -f "${ED}"/usr/include/usbpp.h

	rm -f "${ED}"/usr/lib*/libusb*.la
}
