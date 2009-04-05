# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nexuiz/nexuiz-2.4.2.ebuild,v 1.4 2009/04/03 17:32:59 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs games

MY_PN=Nexuiz
MY_P=${PN}-${PV//./}
MAPS=nexmappack_r2
DESCRIPTION="Deathmatch FPS based on DarkPlaces, an advanced Quake 1 engine"
HOMEPAGE="http://www.nexuiz.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	maps? ( mirror://sourceforge/${PN}/${MAPS}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="alsa dedicated maps opengl sdl"

UIRDEPEND="media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	virtual/opengl
	alsa? ( media-libs/alsa-lib )
	sdl? ( media-libs/libsdl )"
UIDEPEND="x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="media-libs/jpeg
	net-misc/curl
	opengl? ( ${UIRDEPEND} )
	!dedicated? ( !opengl? ( ${UIRDEPEND} ) )"
DEPEND="${RDEPEND}
	app-arch/unzip
	opengl? ( ${UIDEPEND} )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}/darkplaces

src_unpack() {
	unpack ${MY_P}.zip

	local f
	for f in "${MY_PN}"/sources/*.zip ; do
		unpack ./${f}
	done

	if use maps ; then
		cd "${WORKDIR}"/${MY_PN}
		unpack ${MAPS}.zip
	fi
}

src_prepare() {
	# Make the game automatically look in the correct data directory
	sed -i \
		-e "s:gamedirname1:\"${PN}\":" \
		fs.c \
		|| die "sed failed"

	sed -i \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "s:-O2:${CFLAGS}:" \
		-e "/-lm/s:$: ${LDFLAGS}:" \
		-e '/^STRIP/s/strip/true/' \
		makefile.inc \
		|| die "sed failed"

	# This is the right dir, so that e.g. "darkplaces -game nexuiz" will work
	sed -i \
		-e "s:ifdef DP_.*:DP_FS_BASEDIR=${GAMES_DATADIR}/quake1\n&:" \
		makefile \
		|| die "sed failed"

	if ! use alsa ; then
		sed -i \
			-e "/DEFAULT_SNDAPI/s:ALSA:OSS:" \
			makefile \
			|| die "sed failed"
	fi
}

src_compile() {
	if use opengl || ! use dedicated ; then
		emake cl-${PN} || die "emake cl-${PN} failed"
		if use sdl ; then
			emake sdl-${PN} || die "emake sdl-${PN} failed"
		fi
	fi
	if use dedicated ; then
		emake sv-${PN} || die "emake sv-${PN} failed"
	fi
}

src_install() {
	if use opengl || ! use dedicated ; then
		dogamesbin ${PN}-glx || die "dogamesbin glx failed"
		newicon darkplaces72x72.png ${PN}.png
		make_desktop_entry ${PN}-glx "Nexuiz (GLX)"
		if use sdl ; then
			dogamesbin ${PN}-sdl || die "dogamesbin sdl failed"
			make_desktop_entry ${PN}-sdl "Nexuiz (SDL)"
			dosym ${PN}-sdl "${GAMES_BINDIR}"/${PN}
		else
			dosym ${PN}-glx "${GAMES_BINDIR}"/${PN}
		fi
	fi

	if use dedicated ; then
		dogamesbin ${PN}-dedicated || die "dogamesbin dedicated failed"
	fi

	cd "${WORKDIR}"/${MY_PN}
	insinto "${GAMES_DATADIR}"/quake1/${PN}
	doins -r data/* || die "doins data failed"

	dodoc Docs/*.txt
	dohtml Docs/*.{htm,html}
	docinto server
	dodoc Docs/server/*.{cfg,txt}

	prepgamesdirs
}
