# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
MY_PN="PrusaSlicer"
MY_PV="$(ver_rs 3 -)"

inherit cmake wxwidgets xdg

inherit git-r3
EGIT_REPO_URI="https://github.com/prusa3d/prusaslicer.git"
EGIT_COMMIT=version_2.7.3-alpha1
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="A mesh slicer to generate G-code for fused-filament-fabrication (3D printers)"
HOMEPAGE="https://www.prusa3d.com/prusaslicer/"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/commit/6c6f90fe4b9a059adde93b7cd32c8b2ba98e555a.patch"

LICENSE="AGPL-3 Boost-1.0 GPL-2 LGPL-3 MIT"
SLOT="0"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/eigen:3
	dev-cpp/tbb:=
	<dev-libs/boost-1.88.0:=[nls]
	dev-libs/cereal
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/gmp:=
	dev-libs/mpfr:=
	media-gfx/openvdb:=
	media-gfx/libbgcode
	net-misc/curl[adns]
	media-libs/glew:0=
	media-libs/libjpeg-turbo:=
	media-libs/libpng:0=
	media-libs/qhull:=
	sci-libs/libigl
	sci-libs/nlopt
	sci-libs/opencascade:=
	<sci-mathematics/cgal-6.0:=
	sys-apps/dbus
	sys-libs/zlib:=
	virtual/opengl
	x11-libs/gtk+:3
	>=x11-libs/wxGTK-3.2.2.1-r3:${WX_GTK_VER}[X,opengl]
	media-libs/nanosvg:=
"
DEPEND="${RDEPEND}
	media-libs/qhull[static-libs]
	test? ( =dev-cpp/catch-2* )
"

PATCHES=( "${DISTDIR}/6c6f90fe4b9a059adde93b7cd32c8b2ba98e555a.patch" )

src_prepare() {
	eapply "${FILESDIR}/prusaslicer-2.7.4-boost-1.85.patch"
	eapply "${FILESDIR}/b21c65de23140b0a3b70024a51ac3eb9f9ec87b8.patch"
	eapply "${FILESDIR}/71aca4f4480fa86bab9144a4ec14922d9fb82e22.patch"
	eapply "${FILESDIR}/11769.patch"
	if has_version ">=sci-libs/opencascade-7.8.0"; then
		eapply "${FILESDIR}/prusaslicer-2.7.2-opencascade-7.8.0.patch"
	fi

	sed -i -e 's/PrusaSlicer-${SLIC3R_VERSION}+UNKNOWN/PrusaSlicer-${SLIC3R_VERSION}+Gentoo/g' version.inc || die

	sed -i -e 's/find_package(OpenCASCADE 7.6.2 REQUIRED)/find_package(OpenCASCADE REQUIRED)/g' \
		src/occt_wrapper/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE="Release"

	setup-wxwidgets

	local mycmakeargs=(
		-DOPENVDB_FIND_MODULE_PATH="/usr/$(get_libdir)/cmake/OpenVDB"

		-DSLIC3R_BUILD_TESTS=$(usex test)
		-DSLIC3R_FHS=ON
		-DSLIC3R_GTK=3
		-DSLIC3R_GUI=ON
		-DSLIC3R_PCH=OFF
		-DSLIC3R_STATIC=OFF
		-DSLIC3R_WX_STABLE=ON
		-Wno-dev
	)

	cmake_src_configure
}

src_test() {
	CMAKE_SKIP_TESTS=(
		"^libslic3r_tests$"
	)
	cmake_src_test
}
