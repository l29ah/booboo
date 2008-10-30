# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/angband/angband-3.0.9.ebuild,v 1.2 2007/09/12 20:46:28 nyhm Exp $

inherit eutils flag-o-matic games

DESCRIPTION="A roguelike dungeon exploration game based on the books of J.R.R.Tolkien"
HOMEPAGE="http://rephial.org/"
SRC_URI="http://rephial.org/downloads/3.0/${P}-src.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="X gtk ncurses sdl"

DEPEND="gtk? ( >=gnome-base/libglade-2.6 )
	X? ( x11-libs/libSM
		 x11-libs/libX11 )
	sdl? ( media-libs/sdl-ttf
		   media-libs/sdl-image )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	local myConf;
	if ! use ncurses && ( use gtk || use X || use sdl); then
		myConf=--disable-curses
	fi
	egamesconf \
		--disable-dependency-tracking \
		--bindir="${GAMES_BINDIR}" \
		--with-setgid="${GAMES_GROUP}" \
		--with-libpath="${GAMES_DATADIR}"/${PN} \
		$myConf \
		$(use_enable gtk) \
		$(use_enable X x11) \
		$(use_enable sdl) \
		|| die
	append-ldflags -Wl,-z,now
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}/xtra
	doins lib/xtra/angband.glade || die "doins angband.glade failed"
	dodoc changes.txt faq.txt readme.txt thanks.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	chmod -R g+w "${ROOT}${GAMES_DATADIR}"/angband/{apex,data,save,user}
}
