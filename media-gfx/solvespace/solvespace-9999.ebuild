# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Parametric 2d/3d CAD"
HOMEPAGE="http://solvespace.com/"
EGIT_REPO_URI="https://github.com/solvespace/solvespace"
EGIT_SUBMODULES=( '*libdxfrw' 'extlib/flatbuffers' 'extlib/q3d' 'extlib/mimalloc' )

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sys-libs/zlib
	dev-libs/json-c
	x11-libs/cairo
	dev-cpp/gtkmm:3.0
	dev-cpp/pangomm
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glu
	media-libs/libpng
	dev-libs/libspnav"
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE="Release"

src_configure() {
	local mycmakeargs=("-DENABLE_TESTS=OFF")
	cmake_src_configure
}
