# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Finite element programs, libraries, and visualization tools - main fem"
HOMEPAGE="http://www.elmerfem.org/"
EGIT_REPO_URI="https://github.com/elmercsc/elmerfem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="mpi +gui"

RDEPEND="
	virtual/blas
	virtual/lapack
	gui? ( dev-qt/qtgui:5 x11-libs/qwt )
	mpi?     ( sys-cluster/mpich2 )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with mpi MPI)
		$(cmake-utils_use_with gui ELMERGUI)
		$(cmake-utils_use_with gui QT5)
	)
	cmake-utils_src_configure
}
