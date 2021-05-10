# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Serproxy is a multi-threaded proxy program for redirecting network socket connections to/from serial links, in cases where the remote end of the serial link doesn't have a TCP/IP stack (eg an embedded or microcontroller system). The proxy allows other hosts on the network to communicate with the system on the remote end of the serial link."
HOMEPAGE="http://www.lspace.nildram.co.uk/freeware.html"
SRC_URI="http://www.lspace.nildram.co.uk/files/${P}.tar.gz http://vperde.l29ah.blasux.ru/dump/3cdac9c05fb3a272e4cc4d7ae433fb17/serproxy-0.1.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin serproxy
	dodoc AUTHORS ChangeLog README TODO serproxy.cfg
}
