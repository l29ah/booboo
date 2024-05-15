# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# due to cadquery-ocp
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1..2} )

inherit distutils-r1 git-r3

DESCRIPTION="Python-based, parametric, BREP modeling framework for 2D and 3D CAD"
HOMEPAGE="https://github.com/gumyr/build123d"
EGIT_REPO_URI="https://github.com/gumyr/build123d"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
# https://github.com/gumyr/build123d/blob/dev/pyproject.toml
RDEPEND="${DEPEND}
	dev-python/cadquery-ocp[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/anytree[${PYTHON_USEDEP}]
		dev-python/ezdxf[${PYTHON_USEDEP}]
		dev-python/ocpsvg[${PYTHON_USEDEP}]
		dev-python/py-lib3mf[${PYTHON_USEDEP}]
		dev-python/svgpathtools[${PYTHON_USEDEP}]
		dev-python/trianglesolver[${PYTHON_USEDEP}]
		sci-libs/nlopt[python,${PYTHON_USEDEP}]
	')
	"
BDEPEND=""

distutils_enable_tests pytest
