# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Xml2rfc generates RFCs and IETF drafts from document source in XML according to the dtd in RFC2629."
HOMEPAGE="https://pypi.python.org/pypi/xml2rfc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/lxml-2.2.7
	>=dev-python/requests-2.5.0"

src_install() {
	distutils-r1_src_install
	keepdir /var/cache/xml2rfc
}
