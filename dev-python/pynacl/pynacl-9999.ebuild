# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy pypy3 )

inherit git-r3 distutils-r1

DESCRIPTION="PyNaCl is a Python binding to the Networking and Cryptography library, a crypto library with the stated goal of improving usability, security and speed."
HOMEPAGE="https://github.com/pyca/pynacl"
EGIT_REPO_URI="https://github.com/pyca/pynacl"

LICENSE="MPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	# FIXME https://github.com/pyca/pynacl
	rm -rf ../${P}-*/temp.*
	distutils-r1_src_install
}
