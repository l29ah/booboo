# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-2.4.ebuild,v 1.5 2014/05/10 05:40:33 ssuominen Exp $

EAPI=3
inherit eutils flag-o-matic games git-r3

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://ufoai.sourceforge.net/"
EGIT_REPO_URI="https://git.code.sf.net/p/ufoai/code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug server editor +client sse profile"

# Dependencies and more instructions can be found here:
# http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
DEPEND="!server? (
		virtual/opengl
		 virtual/glu
		media-libs/libsdl2
		media-libs/sdl2-image[jpeg,png]
		media-libs/sdl2-ttf
		media-libs/sdl2-mixer
		virtual/jpeg
		media-libs/libpng:0
		media-libs/libogg
		media-libs/libvorbis
		x11-proto/xf86vidmodeproto
	)
	net-misc/curl
	sys-devel/gettext
	sys-libs/zlib
	editor? (
		dev-libs/libxml2
		virtual/jpeg
		media-libs/openal
		x11-libs/gtkglext
		x11-libs/gtksourceview:2.0
	)"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use profile; then
		ewarn "USE=\"profile\" is incompatible with the hardened profile's -pie flag."
	fi
}

src_configure() {
	sed -i -e 's#lua5\.1#lua#' build/default.mk

	# they are special and provide hand batched configure file
	local myconf="
		--disable-memory
		--disable-testall
		--disable-ufomodel
		--disable-ufoslicer
		$(use_enable !debug release)
		$(use_enable editor uforadiant)
		$(use_enable server ufoded)
		$(use_enable client ufo)
		$(use_enable sse)
		--enable-ufo2map
		--enable-game
		--disable-paranoid
		$(use_enable profile profiling)
		--bindir="${GAMES_BINDIR}"
		--libdir="$(games_get_libdir)"
		--datadir="${GAMES_DATADIR}/${PN/-}"
		--localedir="${EPREFIX}/usr/share/locale/"
		--prefix="${GAMES_PREFIX}"
	"
	echo "./configure ${myconf}"
	./configure ${myconf} || die
}

src_compile() {
	echo "Running emake!"
	emake || die
	echo "Running emake lang!"
	emake lang || die
	emake maps || die

	if use editor; then
		emake uforadiant || die
	fi
}

src_install() {
	newicon src/ports/linux/ufo.png ${PN}.png || die
	if use server; then
		dobin ufoded || die
		make_desktop_entry ufoded "UFO: Alien Invasion Server" ${PN}
	fi
	if use client; then
		dobin ufo || die
		make_desktop_entry ufo "UFO: Alien Invasion" ${PN}
	fi

	if use editor; then
		dobin ufo2map ufomodel || die
	fi

	# install data
	insinto "${GAMES_DATADIR}"/${PN/-}
	doins -r base || die
	rm -rf "${ED}/${GAMES_DATADIR}/${PN/-}/base/game.so"
	dogameslib base/game.so

	# move translations where they belong
	dodir "${GAMES_DATADIR_BASE}/locale" || die
	mv "${ED}/${GAMES_DATADIR}/${PN/-}/base/i18n/"* \
		"${ED}/${GAMES_DATADIR_BASE}/locale/" || die
	rm -rf "${ED}/${GAMES_DATADIR}/${PN/-}/base/i18n/" || die

	prepgamesdirs
}
