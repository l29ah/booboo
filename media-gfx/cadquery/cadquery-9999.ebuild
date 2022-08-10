# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5..11} )

inherit distutils-r1 git-r3

DESCRIPTION="A parametric CAD scripting framework based on PythonOCC"
HOMEPAGE="https://github.com/CadQuery/cadquery"
EGIT_REPO_URI="https://github.com/CadQuery/cadquery"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/pythonocc-cadquery-0.18.2"
BDEPEND=""

src_prepare() {
	sed -i -e '/ "tests"/d' setup.py || die
	default
}
