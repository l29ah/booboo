# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils gnuconfig cvs

HM=${PN#husky-}
ECVS_AUTH="pserver"
ECVS_SERVER="husky.cvs.sourceforge.net:/cvsroot/husky"
ECVS_MODULE="${HM}"
ECVS_CVS_COMPRESS="-z3"

DESCRIPTION="FTN husky ${HM} library"
SRC_URI=""
HOMEPAGE="http://husky.sf.net"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND="net-ftn/husky-huskylib
		net-ftn/husky-smapi
		net-ftn/husky-fidoconf"

S="${WORKDIR}/${ECVS_LOCALNAME}"

src_compile() {
    cd "${S}/${HM}"
    emake RPM_BUILD_ROOT=1 || die "Sorry! Do can not compile"
}

src_install() {
    cd "${S}/${HM}"
  	emake RPM_BUILD_ROOT=1 DESTDIR="${D}" LDCONFIG="" install || die "Sorry! Do can not install"
}
