# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Functionality for types"
HOMEPAGE="https://pypi.org/project/typish/
	https://github.com/ramonhagenaars/typish"
SRC_URI="
	https://github.com/ramonhagenaars/typish/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/nptyping[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
