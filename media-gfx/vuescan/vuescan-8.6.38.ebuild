# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="A high-quality scanning and digital camera raw image processing software."
HOMEPAGE="http://www.hamrick.com/"
SRC_URI="http://www.hamrick.com/files/vuesca86.tgz -> ${P}.tgz"
RESTRICT="primaryuri"

LICENSE="vuescan"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MY_LINGUAS="ar be bg ca cs da de el en es et fi fr gl he hi hr hu id it ja ko lt lv nl no pb pl pt ro ru sk sl sr sv ta th tl tr tw uk vi zh"

for MY_LINGUA in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${MY_LINGUA/-/_}"
done

S="${WORKDIR}/VueScan"

INSTALLDIR="/opt/${PN}"

DEPEND=""
RDEPEND=">=x11-libs/gtk+-2.0
		media-gfx/sane-backends
	x86? ( dev-libs/libusb
	      || ( sys-libs/libstdc++-v3 =sys-devel/gcc-3.3* ) )

	amd64? ( app-emulation/emul-linux-x86-baselibs
		 app-emulation/emul-linux-x86-compat
		 app-emulation/emul-linux-x86-xlibs
		 app-emulation/emul-linux-x86-gtklibs )"

src_unpack() {
	unpack ${P}.tgz
	cd ${S}
}

src_install() {
	for LINGUA in ${MY_LINGUAS}; do
		if ! use linguas_${LINGUA/-/_}; then
			rm -f lan_"${LINGUA}".txt
		fi
	done

	insinto ${INSTALLDIR}
	doins vuescan.bmp vuescan.dat ocr_en.bin *htm lan_*.txt

	exeinto ${INSTALLDIR}
	doexe vuescan

	exeinto /usr/bin
	# Provide a simple exec wrapper
	doexe ${FILESDIR}/vuescan
	
	doicon ${FILESDIR}/VueScan.png

	make_desktop_entry "${INSTALLDIR}/${PN}" vuescan VueScan.png Graphics
}

pkg_postinst() {
	einfo "VueScan expects the webbrowser Mozilla installed in your PATH."
	einfo "You have to change this in the 'Prefs' tab or make available"
	einfo "a symlink/script named 'mozilla' starting your favourite browser."
	einfo "Otherwise VueScan will fail to show the HTML documentation."

	if use amd64 ; then
		ewarn "VueScan needs 32bit version of the libusb library."
		ewarn "You need to install it yourself since it is not provided with Gentoo."
		ewarn "Good luck."
	fi
	
	einfo "To use scanner with Vuescan under user you need add user into scanner group."
	einfo "Just run under root: gpasswd -a username scanner"
}
