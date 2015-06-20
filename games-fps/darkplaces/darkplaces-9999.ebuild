# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic versionator games subversion git-2

DESCRIPTION="Enhanced engine for iD Software's Quake 1"
HOMEPAGE="http://icculus.org/twilight/darkplaces/"
ESVN_REPO_URI="svn://svn.icculus.org/twilight/trunk/darkplaces"
EGIT_REPO_URI="git://git.xonotic.org/xonotic/darkplaces.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa dedicated nexuiz opengl oss sdl xonotic"

UIDEPEND="x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
UIRDEPEND="alsa? ( media-libs/alsa-lib )
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
COMMON="media-libs/jpeg
	media-libs/libpng
	sdl? (
		media-libs/libsdl
		${UIDEPEND} )
	opengl? (
		virtual/opengl
		${UIDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIDEPEND} ) ) )"
RDEPEND="sdl? (
		media-libs/libsdl
		${UIRDEPEND} )
	opengl? (
		virtual/opengl
		${UIRDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIRDEPEND} ) ) )"
DEPEND=" !games-fps/nexuiz
	virtual/pkgconfig
	app-arch/unzip
	dev-util/subversion
	games-util/fteqcc
	sdl? (
		media-libs/libsdl
		${UIDEPEND} )
	opengl? (
		virtual/opengl
		${UIDEPEND} )
	!dedicated? (
		!sdl? (
			!opengl? (
				virtual/opengl
				${UIDEPEND} ) ) )"

default_client() {
	if use opengl || $( ! use dedicated && ! use sdl ) ; then
		# Build default client
		return 0
	fi
	return 1
}

pkg_setup() {
	games_pkg_setup

	if default_client && ! use opengl ; then
		die "You must select dedicated server, opengl client or both to build"
	fi

	if use nexuiz && use xonotic ; then
		die "Choose either nexuiz or xonotic darkplaces to build\n \
		(nexuiz may work on xonotic darkplaces)"
	fi
}

src_unpack() {

	# Make the game automatically look in the correct data directory for nexuiz
	if use nexuiz ; then
		subversion_src_unpack
		sed -i "s:gamedirname1:\"nexuiz\":" fs.c \
			|| die "sed fs.c failed"
	fi

	if use xonotic ; then
		git_src_unpack
		cd "$S"
	fi

	# Only additional CFLAGS optimization is the -march flag
	local march=$(get-flag -march)
	sed -i makefile.inc \
		-e '/^CC=/d' \
		-e "s:-lasound:$(pkg-config --libs alsa):" \
		-e "s:CPUOPTIMIZATIONS=:CPUOPTIMIZATIONS=${march}:" \
		|| die "sed makefile.inc failed"

	# Reduce SDL audio buffer, to fix latency
	sed -i "s:requested->speed / 20.0:512:" snd_sdl.c \
		|| die "sed snd_sdl.c failed"

	# Default sound is alsa.
	if ! use alsa ; then
		if use oss ; then
			sed -i "s:DEFAULT_SNDAPI=ALSA:DEFAULT_SNDAPI=OSS:" makefile \
				|| die "sed oss failed"
		else
			sed -i "s:DEFAULT_SNDAPI=ALSA:DEFAULT_SNDAPI=NULL:" makefile \
				|| die "sed null failed"
		fi
	fi
}

src_compile() {
	#Add default dir where we store our stuff to makeopts
	MAKEOPTS="${MAKEOPTS} DP_FS_BASEDIR=${GAMES_DATADIR}/quake1"

	if default_client ; then
		if use nexuiz || use xonotic ; then
			emake cl-nexuiz || die "emake cl-nexuiz failed"
		fi

		emake cl-release || die "emake cl-release failed"
	fi

	if use sdl ; then
		if use nexuiz || use xonotic ; then
			emake sdl-nexuiz || die "emake sdl-nexuiz failed"
		fi

		emake sdl-release || die "emake sdl-release failed"
	fi

	if use dedicated ; then
		if use nexuiz || use xonotic ; then
			emake sv-nexuiz || die "emake sv-nexuiz failed"
		fi

		emake sv-release || die "emake sv-release failed"
	fi
}

src_install() {
	if default_client || use sdl ; then
		newicon darkplaces72x72.png ${PN}.png
	fi

	if use nexuiz ; then
		newicon nexuiz.ico nexuiz.ico
	fi

	if default_client ; then
		newgamesbin ${PN}-glx ${PN} || die "dogamesbin darkplaces-glx failed"
		if use nexuiz || use xonotic ; then
			dogamesbin nexuiz-glx || die "dogamesbin nexuiz-glx failed"
		fi
	fi

	if use sdl ; then
		dogamesbin ${PN}-sdl || die "dogamesbin sdl failed"
		if use nexuiz || use xonotic ; then
			dogamesbin nexuiz-sdl || die "dogamesbin nexuiz-sdl failed"
		fi
	fi

	if use dedicated ; then
		newgamesbin ${PN}-dedicated ${PN}-ded || die "newgamesbin ded failed"
		if use nexuiz || use xonotic ; then
			dogamesbin nexuiz-dedicated || die "dogamesbin nexuiz-dedicated failed"
		fi
	fi

	prepgamesdirs
}
