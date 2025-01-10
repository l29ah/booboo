# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION=""
HOMEPAGE="https://pypi.org/project/ocpsvg/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/svgelements[${PYTHON_USEDEP}]
"
BDEPEND="
"

distutils_enable_tests pytest
