# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{1..3} )

inherit git-r3 cmake python-r1

DESCRIPTION="A lightweight C++11 Distributed Hash Table implementation"
HOMEPAGE="https://github.com/savoirfairelinux/opendht/blob/master/README.md"
EGIT_REPO_URI="https://github.com/savoirfairelinux/${PN}.git"

if [[ ${PV} == *9999* ]]; then
	EGIT_BRANCH="master"
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"

SLOT="0"

IUSE="doc python static-libs tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-cpp/msgpack-cxx
	dev-cpp/asio
	>=net-libs/gnutls-3.3
	python? ( dev-python/cython[${PYTHON_USEDEP}] )
	tools? ( sys-libs/readline:0 )"
RDEPEND="${PYTHON_DEPS}
	${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DOPENDHT_PYTHON=$(usex python)
		-DOPENDHT_STATIC=$(usex static-libs)
		-DOPENDHT_TOOLS=$(usex tools)
	)
	cmake_src_configure
}

src_install() {
	use !doc && rm README.md
	cmake_src_install
}
