# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.50-r1.ebuild,v 1.11 2009/04/14 22:32:08 nyhm Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="http://ftp.hu.freebsd.org/pub/linux/distributions/frugalware/frugalware-testing/source/games-extra/jumpnbump/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
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
	epatch "${FILESDIR}"/${P}-64bit-c99-types-fix.patch
}

src_configure() {
	cd jumpnbump-1.50
	econf
}

src_compile() {
	cd jumpnbump-1.50
	emake
}

src_install() {
	cd jumpnbump-1.50
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
