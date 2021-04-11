# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{3,4,5,6,7,8,9} pypy )

inherit git-r3 distutils-r1

DESCRIPTION="Convert text with ANSI color codes to HTML"
HOMEPAGE="https://pypi.python.org/pypi/ansi2html https://github.com/ralphbean/ansi2html"
EGIT_REPO_URI="https://github.com/ralphbean/ansi2html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.3[${PYTHON_USEDEP}]"
DEPEND="
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' python2_7 pypy)
	)
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

src_compile() {
	emake || die
	distutils-r1_src_compile
}

python_test() {
	chmod -x "${S}"/tests/* || die
	esetup.py check
	esetup.py test
}

python_install_all() {
	doman man/ansi2html.1
	DOCS=(  README.rst man/ansi2html.1.txt )
	distutils-r1_python_install_all
}
