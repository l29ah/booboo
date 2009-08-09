# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="PANDA-glGo is a board interface for Go games"
HOMEPAGE="http://www.pandanet.co.jp/English/glgo/"
SRC_URI="http://www.pandanet.co.jp/English/glgo/downloads/glGo-1.4.1.tar.gz"

LICENSE="panda"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="openal sdl"
RESTRICT="nomirror"

DEPEND=""
RDEPEND="
	media-libs/glitz
	media-libs/jpeg
	media-libs/libcaca
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/svgalib
	x11-base/xorg-server
	x11-libs/gtk+:2
	x11-libs/libXinerama
	dev-lang/python:2.5

	openal? ( media-libs/openal )
	sdl? ( media-libs/sdl-mixer )"

S=${WORKDIR}/usr

src_unpack() {
	tar xzf ${DISTDIR}/${A}
	tar xf glGo.ss
}

src_compile() {
	# Do nothing
	:
}

src_install() {
	DESTINATION=${GAMES_PREFIX_OPT}/gogl

	# Liberaries
	dodir ${DESTINATION}/lib
	insinto ${DESTINATION}/lib
	doins  lib/games/glGo/*

	# Scripts/executables
	dodir ${DESTINATION}/bin
	exeinto ${DESTINATION}/bin
	doexe games/*

	# Shared files
	dodir ${DESTINATION}/share
	insinto ${DESTINATION}/share
	doins -r share/games/glGo/*

	prepgamesdirs

	# Documentation
	dodoc share/doc/glGo/*
	insinto /usr/share/doc/${PF}
	doins -r share/doc/glGo/html

	# Desktop integration
	make_wrapper glGo ./bin/glGo ${DESTINATION} ${DESTINATION}/lib \
		${GAMES_BINDIR}
	make_desktop_entry glGo "glGo"
}
