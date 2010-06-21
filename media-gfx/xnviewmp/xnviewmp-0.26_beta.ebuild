# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
#SRC_URI="x86? ( http://download.xnview.com/XnViewMP-linux.tgz -> ${PN}-${PV/_beta/}.tgz )"
SRC_URI="http://download.xnview.com/XnViewMP-linux.tgz -> ${PN}-${PV/_beta/}.tgz"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	|| ( >=x11-libs/qt-4.3.0:4 ( x11-libs/qt-gui:4 ) )"
DEPEND=""

RESTRICT="strip"
S="${WORKDIR}/XnViewMP-026"
INSTALL_DIR="/opt/xnview"

src_unpack() {
	unpack ${PN}-${PV/_beta/}.tgz
	cd ${S}
	sed -i -e "s:./xnview:${INSTALL_DIR}/xnview  \"\$\@\":" xnview.sh || die
	sed -i -e "s:LD_LIBRARY_PATH=./:LD_LIBRARY_PATH=${INSTALL_DIR}:" xnview.sh || die
}

src_install() {

	dodir ${INSTALL_DIR}
	insinto ${INSTALL_DIR}
	# Install only needed stuff
	doins README country.txt xnview xnview.sh
	# Install 32bit binary libraries that provided with the programs
	doins -r lib

	exeinto ${INSTALL_DIR}
	doexe xnview
	doexe xnview.sh
	
	exeinto /usr/bin
	# Provide a simple exec wrapper
	doexe ${FILESDIR}/xnview

	insinto /usr/share/applications/
	doins ${FILESDIR}/xnview.desktop

	insinto /usr/share/icons/
	doins ${FILESDIR}/xnview.png
}
