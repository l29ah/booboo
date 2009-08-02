# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/anaglyph-stereo-quake/anaglyph-stereo-quake-130100-r1.ebuild,v 1.13 2006/12/04 22:55:45 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="play Quake in 3D with red - blue glasses"
HOMEPAGE="http://home.iprimus.com.au/crbean/"
SRC_URI="http://home.iprimus.com.au/crbean/zip/3dGLQuake_SRC_${PV}.zip
	mirror://gentoo/${P}-SDL.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXxf86vm
	media-libs/libsdl"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto
	app-arch/unzip"

S=${WORKDIR}/WinQuake

src_unpack() {
	unpack ${A}

	cd "${S}"
	mv GLQUAKE.H glquake.h
	mv GL_DRAW.C gl_draw.c
	mv GL_RMAIN.C gl_rmain.c
	epatch "${FILESDIR}"/stupid-dosformat.patch
	mv Makefile{.linuxi386,}
	epatch "${FILESDIR}"/makefile-path-fixes.patch
	epatch "${FILESDIR}"/fix-sys_printf.patch
	epatch "${FILESDIR}"/makefile-cflags.patch
	epatch "${FILESDIR}"/gentoo-paths.patch
	edos2unix console.c "${WORKDIR}"/${P}-SDL.patch
	epatch "${WORKDIR}"/${P}-SDL.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
}

src_compile() {
	make \
		OPTFLAGS="${CFLAGS}" \
		GENTOO_DATADIR=${GAMES_DATADIR}/quake1 \
		build_release \
		|| die "failed to build WinQuake"
}

src_install() {
	newgamesbin release*/bin/glquake.sdl anaglyph-stereo-quake || die
	dodoc "${WORKDIR}"/readme.id.txt
	dohtml "${WORKDIR}"/3dquake.html
	prepgamesdirs
}
