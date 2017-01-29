# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3 eutils cmake-utils

EGIT_REPO_URI="https://github.com/naihe2010/apvlv"
DESCRIPTION="a PDF Viewer which behaviors like Vim"
HOMEPAGE="https://naihe2010.github.io/apvlv/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug djvu umd"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=app-text/poppler-0.12.3-r3[cairo]
	djvu? ( app-text/djvu )
	umd? ( unwritten/libumd )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	mycmakeargs="$(cmake-utils_use djvu APVLV_WITH_DJVU)
				 $(cmake-utils_use umd APVLV_WITH_UMD)"
	cmake-utils_src_configure
}
