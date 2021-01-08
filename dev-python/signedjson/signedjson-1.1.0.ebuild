# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 python3_7 python3_8 )
inherit distutils-r1

DESCRIPTION="Signs JSON objects with ED25519 signatures."
HOMEPAGE="https://github.com/matrix-org/python-signedjson https://pypi.python.org/pypi/signedjson"
SRC_URI="https://github.com/matrix-org/python-signedjson/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/python-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
