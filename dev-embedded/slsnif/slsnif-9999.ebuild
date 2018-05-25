# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator git-r3 autotools

DESCRIPTION="Serial port logging utility"
HOMEPAGE=https://github.com/aeruder/slsnif
EGIT_REPO_URI=https://github.com/aeruder/slsnif

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	eautoreconf
}
