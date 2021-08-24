# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator autotools

DESCRIPTION="Serial port logging utility"
HOMEPAGE="http://slsnif.sourceforge.net/"
SRC_URI="http://jaist.dl.sourceforge.net/project/slsnif/slsnif/slsnif-0.4.4/slsnif-0.4.4.tar.gz
	https://github.com/aeruder/slsnif/commit/9232b5719f8d840c882ff311d4a2ec8b23a2c88a.patch"

PATCHES=( "${DISTDIR}/9232b5719f8d840c882ff311d4a2ec8b23a2c88a.patch" )

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	default
	eautoreconf
}
