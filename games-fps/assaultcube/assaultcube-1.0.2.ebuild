# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib games

EAPI=2

MY_PN="AssaultCube"
DESCRIPTION="AssaultCube - Fast and fun first-person-shooter based on the Cube fps"
HOMEPAGE="http://assault.cubers.net"
SRC_URI="mirror://sourceforge/actiongame/${MY_PN}_v${PV}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client server"
RESTRICT="strip"

DEPEND="sys-libs/glibc
		client? (
			media-libs/openal
			media-libs/mesa
			media-libs/freeglut
			media-libs/libsdl
			media-libs/sdl-mixer
			media-libs/sdl-image
			media-libs/libpng
			virtual/opengl )"

S=${WORKDIR}/${MY_PN}_v${PV}

pkg_setup() {
	if use !client && use !server ; then
		ewarn "You need to build the client or the server";
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/source/src
	cp "${FILESDIR}"/Makefile Makefile
}

src_compile() {
	cd "${S}"/source/src

	emake libenet || die "emake libenet failed"

	if use client ; then
		emake CXXOPTFLAGS="${CXXFLAGS}" client || die "emake client failed"
	fi

	if use server ; then
		emake CXXOPTFLAGS="${CXXFLAGS}" server || die "emake server failed"
	fi
}

src_install() {
	if use client ; then
		exeinto "$(games_get_libdir)"/${PN}
		doexe source/src/ac_client || die
		mv assaultcube.sh assaultcube
		exeinto "${GAMES_BINDIR}"
		doexe "${FILESDIR}"/assaultcube
		dosed "s-^CUBE_DIR=/usr/games/lib/assaultcube-CUBE_DIR=$(games_get_libdir)/${PN}-" "${GAMES_BINDIR}"/assaultcube
		insinto "${GAMES_DATADIR}"/"${PN}"
		doins -r bot config icon.ico packages || die
		make_desktop_entry ${PN} ${PN}
	fi

	if use server ; then
		exeinto "$(games_get_libdir)"/${PN}
		doexe source/src/ac_server || die
		mv server.sh assaultcube-server
		exeinto "${GAMES_BINDIR}"
		doexe "${FILESDIR}"/assaultcube_server
		dosed "s-^CUBE_DIR=/usr/games/lib/assaultcube-CUBE_DIR=$(games_get_libdir)/${PN}-" "${GAMES_BINDIR}"/assaultcube_server
	fi

	dohtml -r README.html docs mods

	prepgamesdirs
}
