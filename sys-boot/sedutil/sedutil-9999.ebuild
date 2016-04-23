# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 linux-info

DESCRIPTION="The Drive Trust Alliance Self Encrypting Drive Utility"
HOMEPAGE="https://github.com/Drive-Trust-Alliance/sedutil/"
EGIT_REPO_URI="https://github.com/Drive-Trust-Alliance/sedutil/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sys-kernel/linux-headers"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/linux/CLI"

src_prepare() {
	sed -i -e '/nvme\.h/a#include "linux/nvme_ioctl.h"' ../DtaDevLinuxNvme.h || die
	get_version
	mkdir ../linux
	cp $KV_DIR/include/linux/nvme.h ../linux/ || die
}

src_install() {
	dobin `find . -executable -type f`
}
