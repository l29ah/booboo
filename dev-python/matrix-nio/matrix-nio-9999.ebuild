# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7,8} )
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
	>=dev-python/h11-0.7.0
	>=dev-python/hyper-h2-3.0.1
	>=dev-python/atomicwrites-1.2.1
	>=dev-python/peewee-3.8.1
	>=dev-python/attrs-18.2.0
	>=dev-python/future-0.16.0-r1
	>=dev-python/jsonschema-2.6.0
	dev-python/logbook
	dev-python/typing"
RDEPEND="${DEPEND}"
