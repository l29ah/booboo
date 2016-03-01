# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="an advanced DICOM viewer and dicomizer that can also be used to convert png, jpeg, bmp, pdf, tiff to DICOM files"
HOMEPAGE="http://ginkgo-cadx.com/"
EGIT_REPO_URI="https://github.com/gerddie/ginkgocadx"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=sci-libs/vtk-6.2[rendering]
	>=sci-libs/itk-4.8
	dev-db/sqlite
	dev-libs/openssl
	>=sci-libs/dcmtk-3.6.1_pre20150924
	>=x11-libs/wxGTK-3.0.1:3.0[opengl]
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	[ `wx-config --release` = 3.0 ] || die "Pick wxwidgets-3.0 in 'eselect wxwidgets'"
}

src_prepare() {
	# clang++ fails otherwise
	sed -i -e 's#operator const std::string *() const#operator std::string () const#g' cadxcore/api/controllers/imodulecontroller.*
}

src_configure() {
	local mycmakeargs=(
		-DITK_DIR="/usr/$(get_libdir)/InsightToolkit"
	)
	cmake-utils_src_configure
}
