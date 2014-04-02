# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python interface to DBus notifications"
HOMEPAGE="https://pypi.python.org/pypi/notify2/0.3"
SRC_URI="https://pypi.python.org/packages/source/n/$PN/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	dev-python/dbus-python"

RDEPEND="${DEPEND}"

