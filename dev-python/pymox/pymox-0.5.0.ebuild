# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P="mox-${PV}"

DESCRIPTION="A mock object framework for Python."
HOMEPAGE="http://code.google.com/p/pymox/"
RESTRICT="mirror"
SRC_URI="http://pymox.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_test() {
	PYTHONPATH="." "${python}" mox_test.py || die "tests failed"
}
