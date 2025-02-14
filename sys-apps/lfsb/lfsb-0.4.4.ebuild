# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Linux utility to change the FSB frequency without having to reboot"
HOMEPAGE="https://sourceforge.net/projects/lfsb"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodoc README
	dosbin src/lfsb
}
