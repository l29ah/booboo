# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Library and python module for pocketing and profiling operations"
HOMEPAGE="https://github.com/Heeks/libarea"
EGIT_REPO_URI="https://github.com/Heeks/libarea"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "$FILESDIR/libarea-providing-library-path-cmake.patch" )

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
	)
	cmake_src_configure
}
