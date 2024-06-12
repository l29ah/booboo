# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..13} )

inherit distutils-r1

DESCRIPTION="A simple wrapper around optparse for powerful command line utilities."
HOMEPAGE="https://pypi.python.org/pypi/cflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/pyusb-1.0.0_beta2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -rf test
	default
}
