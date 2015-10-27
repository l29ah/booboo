# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="SIP (RFC3261) implementation written in C, with an object oriented API"
HOMEPAGE="http://www.linphone.org/technical-corner/belle-sip/overview"
EGIT_REPO_URI="git://git.linphone.org/belle-sip.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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

src_prepare() {
	sed -i -e 's#-Werror##g' CMakeLists.txt
	cmake-utils_src_prepare
}
