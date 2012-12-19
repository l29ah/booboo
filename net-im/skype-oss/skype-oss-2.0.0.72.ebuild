# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.0.0.68.ebuild,v 1.2 2008/07/28 21:28:27 carlo Exp $

EAPI=4

inherit eutils qt4-r2 pax-utils

DESCRIPTION="A P2P-VoiceIP client, statically linked against OSS binary"
HOMEPAGE="http://www.skype.com/"

FILENAME=${PN/-oss/}_static-${PV}-oss.tar.bz2
# Dead
#SRC_URI="http://download.skype.com/linux/${FILENAME}"
SRC_URI='http://kobyla.info/soft/distfiles/skype_static-2.0.0.72-oss.tar.bz2'

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

IUSE="oss4"

DEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat )
	x86? ( >=sys-libs/glibc-2.4
		x11-libs/libXScrnSaver
		x11-libs/libXv
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libX11 )
	oss4? ( || ( media-sound/oss media-sound/oss-devel ) )
		!net-im/skype"

RDEPEND="${DEPEND}"

QA_EXECSTACK="opt/${PN}/skype"

S="${WORKDIR}/${PN/-oss/}_static-${PV}-oss"

src_unpack() {
	unpack ${A}
}

src_install() {
	# remove mprotect() restrictions for PaX usage - see Bug 100507
#	pax-mark m "${S}"/skype

	exeinto /opt/${PN}
	doexe skype
	fowners root:audio /opt/${PN}/skype
	make_wrapper skype /opt/${PN}/skype /opt/${PN} /opt/${PN} /usr/bin

	insinto /opt/${PN}/sounds
	doins sounds/*.wav

	insinto /opt/${PN}/lang

	doins lang/*.qm

	insinto /opt/${PN}/avatars
	doins avatars/*.png

	insinto /opt/${PN}
	for X in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}"/icons/SkypeBlue_${X}x${X}.png ${PN}.png
	done

	dodoc README

	# insinto /usr/share/applications/
	# doins skype.desktop
	make_desktop_entry ${PN/-oss/} "Skype VoIP" ${PN} "Network;InstantMessaging;Telephony"

	#Fix for no sound notifications
	dosym /opt/${PN} /usr/share/${PN}

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
	# doexe skype-callto-handler
}

pkg_postinst() {
	elog "If you have sound problems please visit: "
	elog "http://forum.skype.com/bb/viewtopic.php?t=4489"
	elog "These kernel options are reported to help"
	elog
	elog "Processor type and features --->"
	elog "-- Preemption Model (Preemptible Kernel (Low-Latency Desktop))"
	elog "-- Timer frequency (250 HZ)"
	elog
	ewarn "This release no longer uses the old wrapper because ${PN} now uses OSS4"
	ewarn

}
