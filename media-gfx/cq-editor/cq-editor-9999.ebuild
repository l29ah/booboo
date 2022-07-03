# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )

inherit distutils-r1 git-r3

DESCRIPTION="CadQuery GUI editor based on PyQT"
HOMEPAGE="https://github.com/CadQuery/CQ-editor"
EGIT_REPO_URI="https://github.com/CadQuery/CQ-editor"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets]
	media-gfx/cadquery[${PYTHON_USEDEP}]
	dev-python/spyder[${PYTHON_USEDEP}]
	dev-python/logbook[${PYTHON_USEDEP}]
	"
BDEPEND=""
