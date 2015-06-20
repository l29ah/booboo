# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

ESVN_REPO_URI="http://apvlv.googlecode.com/svn/trunk"
inherit eutils subversion cmake-utils

DESCRIPTION="a PDF Viewer which behaviors like Vim"
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI="http://dump.bitcheese.net/files/yroveme/apvlv-bump-page-render-api.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug djvu umd"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=app-text/poppler-0.12.3-r3[cairo,gdk]
	<app-text/poppler-0.17[cairo,gdk]
	djvu? ( app-text/djvu )
	umd? ( unwritten/libumd )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	subversion_src_prepare
	epatch "$DISTDIR/apvlv-bump-page-render-api.patch"
}

src_configure() {
	mycmakeargs="$(cmake-utils_use djvu APVLV_WITH_DJVU)
				 $(cmake-utils_use umd APVLV_WITH_UMD)"
	cmake-utils_src_configure
}
