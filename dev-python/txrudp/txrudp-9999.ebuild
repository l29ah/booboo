# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy pypy3 )

inherit git-r3 distutils-r1

DESCRIPTION="Implementation of a Reliable UDP Protocol Layer over Twisted."
HOMEPAGE="https://pypi.python.org/pypi/txrudp"
EGIT_REPO_URI="https://github.com/OpenBazaar/txrudp"

LICENSE="MPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s#'tests'##" setup.py
}
