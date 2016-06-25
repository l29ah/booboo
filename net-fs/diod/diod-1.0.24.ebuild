# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Distributed I/O Daemon - a 9P file server"
HOMEPAGE="https://github.com/chaos/diod"
SRC_URI="https://github.com/chaos/diod/releases/download/$PV/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
