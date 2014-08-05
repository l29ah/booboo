# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="A high-quality scanning and digital camera raw image processing software."
HOMEPAGE="http://www.hamrick.com/"
RESTRICT="primaryuri"

LICENSE="vuescan"
SLOT="0"
KEYWORDS=""
IUSE="doc"

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
	# FIXME use the common DISTDIR pathway
	wget -c "https://www.hamrick.com/files/vuesca86.tgz"
	tar -xzf vuesca86.tgz || die "Unpack failed"
	cd ${S}
	use doc && wget -c "https://www.hamrick.com/vuescan/${PN}.pdf"
}

src_install() {
	if use doc; then
		dodoc ${PN}.pdf
	fi

	exeinto ${INSTALLDIR}
	doexe vuescan

	exeinto /usr/bin
	# Provide a simple exec wrapper
	doexe ${FILESDIR}/vuescan
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
