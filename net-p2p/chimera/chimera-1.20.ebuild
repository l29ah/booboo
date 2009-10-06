# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Chimera, a light-weight & efficient implementation of a structured
peer-to-peer overlay network"
HOMEPAGE="http://current.cs.ucsb.edu/projects/chimera/index.html"
SRC_URI="http://www.cs.ucsb.edu/%7Eravenben/chimera/download/chimera-1.20.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd $PN
	econf
	emake
}

src_install() {
	cd $PN
	einstall
}
