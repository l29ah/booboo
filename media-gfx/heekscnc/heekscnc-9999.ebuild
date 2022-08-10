# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="HeeksCAD-based CAM"
HOMEPAGE="https://github.com/Heeks/heekscnc"
EGIT_REPO_URI="https://github.com/Heeks/heekscnc"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	media-gfx/heekscad
	sci-libs/oce
	sci-libs/libarea
	|| ( x11-libs/wxGTK:3.0 x11-libs/wxGTK:2.8 )"
DEPEND="$RDEPEND"

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
	)
	cmake_src_configure
}
