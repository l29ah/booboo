# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 )
inherit distutils-r1

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles"
HOMEPAGE="https://github.com/poljar/matrix-nio"
if [[ ${PV} == 9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/poljar/${PN}.git"
else
        SRC_URI="https://github.com/poljar/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""

DEPEND="dev-python/python-olm
	dev-python/h11
	dev-python/hyper-h2
	dev-python/attrs
	dev-python/future
	dev-python/logbook
	dev-python/typing"
RDEPEND="${DEPEND}"
