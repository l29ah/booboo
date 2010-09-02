# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mercurial toolchain-funcs
EAPI="2"

DESCRIPTION="st is a simple terminal implementation for X."
HOMEPAGE="http://st.suckless.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libX11"

EHG_REPO_URI=http://suckless.org/cgi-bin/hgwebdir.cgi/${PN}

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e "s/.*strip.*//" \
		Makefile || die "sed failed"

	sed -i \
		-e "s/CFLAGS = -Os/CFLAGS +=/" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
		config.mk || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	dodoc README
}
