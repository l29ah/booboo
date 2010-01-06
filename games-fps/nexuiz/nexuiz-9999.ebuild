# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs games subversion

DESCRIPTION="Deathmatch FPS based on DarkPlaces, an advanced Quake 1 engine"
HOMEPAGE="http://www.nexuiz.com/"
ESVN_REPO_URI="svn://svn.icculus.org/nexuiz/trunk"

EAPI="2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="pack"

RDEPEND="games-fps/darkplaces[nexuiz]
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/subversion
	games-util/fteqcc
	pack? ( app-arch/p7zip )"

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	cd ${WORKDIR}/${PF}/data/

	emake qc || die "emake qc failed"

	rm -r qcsrc/

	if use pack ; then
		einfo "Compressing data"
		7za a -tzip -mx=9 -x\!*.pk3 data$( date +%Y%m%d ).pk3 ./ || die "Failed to compress data"
	fi
}

src_install() {
	if use opengl || ! use dedicated ; then
		make_desktop_entry nexuiz-glx "Nexuiz (GLX)" nexuiz.ico "Games"
		if use sdl ; then
			make_desktop_entry nexuiz-sdl "Nexuiz (SDL)" nexuiz.ico "Games"
			dosym ${PN}-sdl "${GAMES_BINDIR}"/${PN}
		else
			dosym ${PN}-glx "${GAMES_BINDIR}"/${PN}
		fi
	fi

	insinto "${GAMES_DATADIR}"/quake1/${PN}

	if use pack ; then
		doins -r data/*.pk3 || die "doins data failed"
	else
		doins -r data/* || die "doins data failed"
	fi

	dodoc Docs/*.{txt,xml}
	dohtml Docs/*.{htm,html} Docs/htmlfiles/*
	docinto server
	dodoc server/*

	prepgamesdirs
}
