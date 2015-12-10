# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy pypy3 )

inherit git-r3 distutils-r1

DESCRIPTION="(A OpenBazaar's clone of) Python native client for the obelisk blockchain server."
HOMEPAGE="https://github.com/OpenBazaar/python-libbitcoinclient"
EGIT_REPO_URI="https://github.com/OpenBazaar/python-libbitcoinclient"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+bitcoin"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/pyzmq"
