# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# due to cadquery-ocp
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1..2} )

inherit distutils-r1 git-r3

DESCRIPTION="A parametric CAD scripting framework based on PythonOCC"
HOMEPAGE="https://github.com/CadQuery/cadquery"
EGIT_REPO_URI="https://github.com/CadQuery/cadquery"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
# https://github.com/CadQuery/cadquery/blob/master/environment.yml
RDEPEND="${DEPEND}
	dev-python/cadquery-ocp[${PYTHON_SINGLE_USEDEP}]
	sci-libs/casadi[python,ipopt,mumps,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/typish[${PYTHON_USEDEP}]
		<dev-python/multimethod-2[${PYTHON_USEDEP}]
		dev-python/ezdxf[${PYTHON_USEDEP}]
		dev-python/nptyping[${PYTHON_USEDEP}]
		sci-libs/nlopt[python,${PYTHON_USEDEP}]
	')
	"
BDEPEND=""

distutils_enable_tests pytest

src_prepare() {
	sed -i -e '/ "tests"/d' setup.py || die
	default
}
