# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="A satellite orbit prediction library"
HOMEPAGE="https://github.com/la1k/libpredict"
EGIT_REPO_URI="https://github.com/la1k/libpredict"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# https://github.com/la1k/libpredict/issues/113
	sed -i -e 's#-Werror##' CMakeLists.txt
	cmake_src_prepare
}
