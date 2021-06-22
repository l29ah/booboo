# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs git-r3

DESCRIPTION="Quick Image Viewer"
HOMEPAGE="http://spiegl.de/qiv/"
EGIT_REPO_URI='https://codeberg.org/ciberandy/qiv'

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

src_prepare() {
	sed -i \
		-e 's:$(CC) $(CFLAGS):$(CC) $(LDFLAGS) $(CFLAGS):' \
		Makefile || die

	if ! use xinerama; then
		sed -i \
			-e 's:-DGTD_XINERAMA::' \
			Makefile || die
	fi
	default
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin qiv || die
	doman qiv.1
	dodoc Changelog README README.TODO
}
