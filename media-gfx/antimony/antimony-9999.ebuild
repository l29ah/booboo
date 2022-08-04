# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{3,4,5,6,7,8,9,10} )

inherit git-r3 cmake python-single-r1


DESCRIPTION="CAD from a parallel universe"
HOMEPAGE="http://www.mattkeeter.com/projects/antimony/3/"
EGIT_REPO_URI="https://github.com/mkeeter/antimony.git"

LICENSE="MIT"

SLOT="0"

KEYWORDS=""

IUSE=""

# https://github.com/mkeeter/antimony/issues/196
DEPEND="
	>dev-util/lemon-3.8.11 <dev-util/lemon-3.24.0
	sys-devel/flex
	dev-libs/boost[python]
	media-libs/libpng
	dev-qt/qtcore:5
	${PYTHON_DEPS}
	"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# stumbles upon the highest installed python version otherwise
	sed -i -e "s/Python 3\.3 /Python ${EPYTHON/python/} EXACT /" CMakeLists.txt
	cmake_src_prepare
	default
}
