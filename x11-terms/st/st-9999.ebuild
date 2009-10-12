# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mercurial toolchain-funcs
EAPI="2"

DESCRIPTION="st is a simple terminal implementation for X."
HOMEPAGE="http://st.suckless.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-util/mercurial"
RDEPEND="x11-libs/libX11"

#EHG_REPO_URI="http://st.suckless.org/"
EHG_REPO_URI=http://suckless.org/cgi-bin/hgwebdir.cgi/${PN}
EHG_PULL_CMD="hg pull --force --quiet"

S=${WORKDIR}/${PN}

src_unpack() {
	mercurial_src_unpack
	cd "${S}"

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
