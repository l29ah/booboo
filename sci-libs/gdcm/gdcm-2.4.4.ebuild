# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Cross-platform DICOM implementation"
HOMEPAGE="http://sourceforge.net/projects/gdcm/"
SRC_URI="mirror://sourceforge/gdcm/gdcm%202.x/GDCM%20$PV/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples perl python php java doc vtk wxwidgets"

DEPEND="
	sys-libs/zlib
	dev-libs/openssl
	sys-apps/util-linux
	dev-libs/expat
	media-libs/openjpeg
	app-text/poppler
	dev-libs/libxml2
	"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS=-fPIC
		-DCMAKE_CXX_FLAGS=-fPIC
		-DGDCM_USE_SYSTEM_ZLIB=OFF
		-DGDCM_USE_SYSTEM_OPENSSL=OFF
		-DGDCM_USE_SYSTEM_UUID=OFF
		-DGDCM_USE_SYSTEM_EXPAT=OFF
		-DGDCM_USE_SYSTEM_JSON=OFF
		-DGDCM_USE_SYSTEM_PAPYRUS3=OFF
		-DGDCM_USE_SYSTEM_SOCKETXX=OFF
		-DGDCM_USE_SYSTEM_LJPEG=OFF
		-DGDCM_USE_SYSTEM_OPENJPEG=OFF
		-DGDCM_USE_SYSTEM_CHARLS=OFF
		-DGDCM_USE_SYSTEM_POPPLER=OFF
		-DGDCM_USE_SYSTEM_LIBXML2=OFF
		$(cmake-utils_use examples GDCM_BUILD_EXAMPLES)
		$(cmake-utils_use examples GDCM_BUILD_APPLICATIONS)
		$(cmake-utils_use perl GDCM_WRAP_PERL)
		$(cmake-utils_use python GDCM_WRAP_PYTHON)
		$(cmake-utils_use php GDCM_WRAP_PHP)
		$(cmake-utils_use java GDCM_WRAP_JAVA)
		$(cmake-utils_use doc GDCM_DOCUMENTATION)
		$(cmake-utils_use vtk GDCM_USE_VTK)
		$(cmake-utils_use wxwidgets GDCM_USE_WXWIDGETS)
	)
	cmake-utils_src_configure
}
