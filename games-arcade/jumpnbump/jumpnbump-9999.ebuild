# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.50-r1.ebuild,v 1.11 2009/04/14 22:32:08 nyhm Exp $

EAPI=2
inherit autotools eutils games cvs

ECVS_AUTH="pserver"
ECVS_SERVER="cvs.icculus.org:/cvs/cvsroot"
ECVS_MODULE="jumpnbump"
ECVS_LOCALNAME="jumpnbump"
ECVS_PASS="anonymous"


DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="mirror://gentoo/jumpnbump-1.50-autotool.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X fbcon kde svga tk"

DEPEND="X? ( x11-libs/libXext )
	kde? ( || (
		kde-base/kdialog
		kde-base/kdebase ) )
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-net"
RDEPEND="${DEPEND}
	tk? (
		dev-lang/tcl
		dev-lang/tk )"

src_prepare() {
	epatch ../jumpnbump-1.50-autotool.patch
	rm -f configure
	eautoreconf
	sed -i \
		-e "/PREFIX/ s:PREFIX.*:\"${GAMES_DATADIR}/${PN}/jumpbump.dat\":" \
		globals.h \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# clean up a bit.  It leave a dep on Xdialog but ignore that.
	use fbcon || rm -f "${D}${GAMES_BINDIR}/jumpnbump.fbcon"
	use kde || rm -f "${D}${GAMES_BINDIR}/jumpnbump-kdialog"
	use svga || rm -f "${D}${GAMES_BINDIR}/jumpnbump.svgalib"
	use tk || rm -f "${D}${GAMES_BINDIR}/jnbmenu.tcl"
	newicon sdl/jumpnbump64.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Jump n Bump"
	prepgamesdirs
}
