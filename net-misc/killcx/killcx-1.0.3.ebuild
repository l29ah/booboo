# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

RESTRICT="mirror"

DESCRIPTION="Close a TCP connection"
HOMEPAGE="http://killcx.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/killcx/files/${PN}/${PV}/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/NetPacket
	dev-perl/Net-Pcap
	dev-perl/Net-RawIP"
RDEPEND="${DEPEND}"

src_install() {
	dobin killcx
	dodoc README changelog
}
