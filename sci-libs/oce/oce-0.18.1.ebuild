# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils eutils check-reqs multilib java-pkg-opt-2 flag-o-matic

DESCRIPTION="Development platform for CAD/CAE, 3D surface/solid modeling and data exchange"
HOMEPAGE="https://github.com/tpaviot/oce"
SRC_URI="https://github.com/tpaviot/oce/archive/OCE-$PV.tar.gz"

LICENSE="|| ( Open-CASCADE-LGPL-2.1-Exception-1.0 LGPL-2.1 )"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples freeimage gl2ps java qt4 +tbb test +vtk"

MY_VTK="vtk-7.1"
MY_P="oce-OCE-${PV}"
S="${WORKDIR}/${MY_P}"
DEPEND="
	dev-lang/tcl:0=
	dev-lang/tk:0=
	dev-tcltk/itcl
	dev-tcltk/itk
	dev-tcltk/tix
	media-libs/ftgl
	virtual/glu
	virtual/opengl
	x11-libs/libXmu
	freeimage? ( media-libs/freeimage )
	gl2ps? ( x11-libs/gl2ps )
	java? ( >=virtual/jdk-0:= )
	tbb? ( dev-cpp/tbb )
	vtk? ( || ( =sci-libs/${MY_VTK}*[imaging] =sci-libs/${MY_VTK}*[qt4] =sci-libs/${MY_VTK}*[rendering] =sci-libs/${MY_VTK}*[views] =sci-libs/${MY_VTK}*[all-modules] ) )"
RDEPEND="${DEPEND}"

CHECKREQS_MEMORY="256M"
CHECKREQS_DISK_BUILD="3584M"

pkg_setup() {
	check-reqs_pkg_setup
	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	cmake-utils_src_prepare
	java-pkg-opt-2_src_prepare
}

src_configure() {
	# from dox/dev_guides/building/cmake/cmake.md
	local mycmakeargs=(
		-DBUILD_WITH_DEBUG=$(usex debug)
		-DINSTALL_DIR="${EROOT}"usr
		-DINSTALL_DIR_WITH_VERSION=yes
		-DUSE_D3D=no
		-DUSE_FREEIMAGE=$(usex freeimage)
		-DUSE_GL2PS=$(usex gl2ps)
		-DUSE_TBB=$(usex tbb)
		-DUSE_VTK=$(usex vtk)
		-DBUILD_DOC_Overview=$(usex doc)
		-DINSTALL_DOC_Overview=$(usex doc)
		-DINSTALL_SAMPLES=$(usex examples)
		-DINSTALL_TEST_CASES=$(usex test)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
