# Copyright 2022 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION=""
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"
HOMEPAGE="https://sourceforge.net/projects/njconnect/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses
		virtual/jack"

RDEPEND="${DEPEND}"
