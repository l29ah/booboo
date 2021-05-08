# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils cmake-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/prusa3d/PrusaSlicer"
else
	PVE=${PV/_/-}
	SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/version_${PVE}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/PrusaSlicer-version_${PVE}"
fi


DESCRIPTION="G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)"
HOMEPAGE="https://github.com/prusa3d/PrusaSlicer"

LICENSE="AGPL-3 CC-BY-3.0"
SLOT="0"

# hangs in cmake with openvdb-6.2.1 and 7.0
RDEPEND="
	>=dev-libs/boost-1.55[threads]
	dev-cpp/eigen
	dev-cpp/gtest
	dev-libs/cereal
	dev-cpp/tbb
	dev-libs/expat
	dev-libs/openssl
	media-libs/glew
	net-misc/curl
	sci-libs/nlopt
	x11-libs/wxGTK:3.0-gtk3
	>=media-gfx/openvdb-5.0
	|| ( >=media-gfx/openvdb-8.0.1 <media-gfx/openvdb-6.2.1 )
	>=sci-mathematics/cgal-5.0
"

DEPEND="${RDEPEND}"

src_prepare() {
	default

	# don't try to write to /
	# FIXME
	sed -i -e '/install(CODE/d' src/CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSLIC3R_WX_STABLE=1
		-DSLIC3R_GUI=1
		-DSLIC3R_FHS=1
		-DSLIC3R_STATIC=0
		-DSLIC3R_GTK=3
		-DSLIC3R_PERL_XS=0
		-DSLIC3R_BUILD_SANDBOXES=0
		-DSLIC3R_BUILD_TESTS=0
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	make_desktop_entry prusa-slicer \
		"PrusaSlicer"\
		"/usr/share/PrusaSlicer/icons/PrusaSlicer_192px.png" \
		"Graphics;3DGraphics;Engineering;Development"
}
