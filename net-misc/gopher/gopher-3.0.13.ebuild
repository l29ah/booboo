# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Distributed Hypertext Client, Gopher protocol"
HOMEPAGE="http://packages.debian.org/source/sid/gopher"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/g/gopher/gopher_3.0.13.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$RDEPEND
	=sys-devel/autoconf-2.13"
RDEPEND="sys-libs/ncurses:5"

inherit autotools

src_compile() 
{
	cd $PN
	./configure --prefix="$D"
	emake
}

src_install()
{
	cd $PN
	einstall
}
