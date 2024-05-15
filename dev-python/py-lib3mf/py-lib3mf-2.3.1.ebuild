# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1..2} )

inherit distutils-r1 git-r3

DESCRIPTION="Minimal files required to use lib3mf in python."
HOMEPAGE="https://pypi.org/project/py-lib3mf/"
EGIT_REPO_URI="https://github.com/jdegenstein/py-lib3mf"
EGIT_COMMIT="44411b9120f789676a6289dc9ae045741a011a3"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
"
BDEPEND="
"
