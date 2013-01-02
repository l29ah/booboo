# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: FUCK CVS $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cairo"

RDEPEND=">=app-text/mupdf-0.8.165
	>=app-text/zathura-0.2.1
	>=dev-libs/girara-0.1.4:2
	!!app-text/zathura-pdf-poppler
	cairo? ( x11-libs/cairo )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		VERBOSE=1
		DESTDIR="${D}"
		WITH_CAIRO=$(usex cairo 1 0)
		)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
