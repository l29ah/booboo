# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ECVS_AUTH="pserver"
ECVS_SERVER="golded-plus.cvs.sourceforge.net:/cvsroot/golded-plus"
ECVS_MODULE="${PN}"
ECVS_LOCALNAME="${PN}"

inherit eutils gnuconfig cvs

DESCRIPTION="FTN Editor ${PN}"
SRC_URI=""
HOMEPAGE="http://golded-plus.sourceforge.net"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND="sys-libs/ncurses"

S="${WORKDIR}/${ECVS_LOCALNAME}"

src_unpack() {
    cvs_src_unpack 
    cd "${S}"
    cp ./golded3/mygolded.__h ./golded3/mygolded.h
}

src_compile() {
    cd "${S}"
	# patch exists, but not tested
    if [[ "${ABI}" == "amd64" ]]; then
	epatch "$FILESDIR/amd64.patch"
    fi
    epatch "$FILESDIR/nospell.patch"

    sed -i 's/LC_CTYPE,\ \"\"/LC_CTYPE,\ \"C-TRADITIONAL"/g' rddt/rddt.cpp
    sed -i 's/LC_CTYPE,\ \"\"/LC_CTYPE,\ \"C-TRADITIONAL"/g' golded3/geinit.cpp
    sed -i 's/LC_CTYPE,\ \"\"/LC_CTYPE,\ \"C-TRADITIONAL"/g' goldlib/gall/gutlwin.cpp
    sed -i 's/LC_CTYPE,\ \"\"/LC_CTYPE,\ \"C-TRADITIONAL"/g' goldlib/gall/gcharset.cpp
    sed -i 's/LC_CTYPE,\ \"\"/LC_CTYPE,\ \"C-TRADITIONAL"/g' goldnode/goldnode.cpp

    emake PLATFORM=lnx 
    emake PLATFORM=lnx strip
    emake docs	
}

src_install() {
    exeinto	/usr/bin
    doexe	"${S}"/bin/*
    insinto	/usr/doc/"${PN}"
    doins	"${S}"/docs/*
}
