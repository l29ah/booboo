# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7,8} )
inherit distutils-r1

DESCRIPTION="PyMacaroons is a Python implementation of Macaroons. They’re better than cookies!"
HOMEPAGE="https://github.com/ecordell/pymacaroons https://pypi.org/project/pymacaroons/"
SRC_URI="https://github.com/ecordell/pymacaroons/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
