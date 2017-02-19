# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Simple block diagram generator"
HOMEPAGE="http://blockdiag.com/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/pillow
	dev-python/webcolors
	dev-python/funcparserlib"
RDEPEND="${DEPEND}"
