# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="SIP (RFC3261) implementation written in C, with an object oriented API"
HOMEPAGE="http://www.linphone.org/technical-corner/belle-sip/overview"
SRC_URI="https://www.linphone.org/releases/sources/belle-sip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/antlr-c-3.4
	net-libs/polarssl:=
"
DEPEND="${RDEPEND}
	dev-java/antlr:3
	dev-util/intltool
	sys-devel/libtool
	virtual/pkgconfig
"
