# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 eutils

DESCRIPTION="FUSE /dev/null equivalent for directories"
HOMEPAGE="https://github.com/xrgtn/nullfs"
EGIT_REPO_URI="https://github.com/xrgtn/nullfs.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-fs/fuse-2.6.1"
RDEPEND="${DEPEND}"

src_install() {
	dobin "${WORKDIR}/${P}/nul1fs"
	dobin "${WORKDIR}/${P}/nullfs"
	dodoc "${WORKDIR}/${P}/README"
}
