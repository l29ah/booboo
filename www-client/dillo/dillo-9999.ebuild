# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools eutils multilib toolchain-funcs mercurial

DESCRIPTION="Lean FLTK based web browser"
HOMEPAGE="http://www.dillo.org/"
SRC_URI="mirror://gentoo/${PN}.png"
EHG_REPO_URI="http://hg.dillo.org/dillo"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc +gif ipv6 +jpeg +png ssl"

RDEPEND="
	>=x11-libs/fltk-1.3
	sys-libs/zlib
	jpeg? ( virtual/jpeg:0 )
	png? ( >=media-libs/libpng-1.2:0 )
	ssl? ( dev-libs/openssl:0= )
"
DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen )
"

src_prepare() {
	epatch "${FILESDIR}"/${PN}2-inbuf.patch
	eautoreconf
}

src_configure() {
	econf  \
		$(use_enable gif) \
		$(use_enable ipv6) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable ssl) \
		--docdir="/usr/share/doc/${PF}"
}

src_compile() {
	emake AR=$(tc-getAR)
	if use doc; then
		doxygen Doxyfile || die
	fi
}

src_install() {
	dodir /etc
	default

	use doc && dohtml html/*
	dodoc AUTHORS ChangeLog README NEWS
	dodoc doc/*.txt doc/README

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Dillo
}

pkg_postinst() {
	elog "Dillo has installed a default configuration into /etc/dillo/dillorc"
	elog "You can copy this to ~/.dillo/ and customize it"
}
