# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5,3_6,3_7,3_8,3_9} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="A Last.fm API interface."
HOMEPAGE="https://pypi.python.org/pypi/lfmh"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
