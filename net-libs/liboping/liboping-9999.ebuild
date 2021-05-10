# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit autotools git-r3 fcaps

DESCRIPTION="C library and ncurses based program to generate ICMP echo requests and ping multiple hosts at once"
HOMEPAGE="http://noping.cc/"
EGIT_REPO_URI="https://github.com/octo/liboping"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="perl"

DEPEND="
	sys-libs/ncurses
	perl? ( dev-lang/perl )
"
RDEPEND=${DEPEND}

PATCHES=( "${FILESDIR}/${PN}-1.6.2-nouidmagic.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with perl perl-bindings INSTALLDIRS=vendor) \
		--disable-static
}

src_install() {
	default
	find "${D}" -name '*.la'  -delete || die
}

pkg_postinst() {
	fcaps cap_net_raw \
		usr/bin/oping \
		usr/bin/noping
}
