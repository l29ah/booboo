# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-2.2.3.ebuild,v 1.1 2010/03/12 09:17:59 ssuominen Exp $

EAPI=5
inherit toolchain-funcs mercurial

DESCRIPTION="Quick Image Viewer"
HOMEPAGE="http://spiegl.de/qiv/"
EHG_REPO_URI='http://bitbucket.org/ciberandy/qiv/'

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="xinerama"

RDEPEND="x11-libs/gtk+:2
	media-libs/imlib2
	media-libs/libexif
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/$PN"

src_prepare() {
	sed -i \
		-e 's:$(CC) $(CFLAGS):$(CC) $(LDFLAGS) $(CFLAGS):' \
		Makefile || die

	if ! use xinerama; then
		sed -i \
			-e 's:-DGTD_XINERAMA::' \
			Makefile || die
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin qiv || die
	doman qiv.1
	dodoc Changelog README README.TODO
}
