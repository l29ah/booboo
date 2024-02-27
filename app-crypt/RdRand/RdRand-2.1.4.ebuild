# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for generating random numbers using the RdRand instruction on Intel CPUs"
HOMEPAGE="https://github.com/jirka-h/RdRand"
SRC_URI="https://github.com/jirka-h/RdRand/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	# remove garbage
	rm -rf \
		m4 aclocal.m4 autom4te.cache config.guess config.h config.h.in config.log \
		config.status config.sub configure depcomp install-sh librdrand-0.1.la \
		libtool ltmain.sh Makefile Makefile.in missing rdrand-0.1.pc rdrandconfig.h \
		stamp-h1 stamp-h2 src/.deps src/.dirstamp src/rdrand.lo .libs/ INSTALL \
		.deps/ compile

	eautoreconf
}
