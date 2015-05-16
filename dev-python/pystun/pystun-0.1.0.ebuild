# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="A Python STUN client for getting NAT type and external IP (RFC 3489)"
HOMEPAGE="https://pypi.python.org/pypi/pystun"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare_all() {
	# purge test folder to avoid file collisions
	sed -e "s:find_packages():find_packages(exclude=['tests']):" -i setup.py || die
	distutils-r1_python_prepare_all
}
