# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# due to cadquery
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_1{1..2} )

inherit distutils-r1 git-r3

DESCRIPTION="CadQuery GUI editor based on PyQT"
HOMEPAGE="https://github.com/CadQuery/CQ-editor"
EGIT_REPO_URI="https://github.com/CadQuery/CQ-editor"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="$(python_gen_cond_dep '
	test? ( dev-python/pytest-qt[${PYTHON_USEDEP}] )
	')"
RDEPEND="
	media-gfx/cadquery[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets]
		dev-python/spyder[${PYTHON_USEDEP}]
		dev-python/logbook[${PYTHON_USEDEP}]
	')
	"
BDEPEND=""

distutils_enable_tests pytest
