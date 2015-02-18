# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.102.2.2.ebuild,v 1.5 2012/03/23 20:14:06 tupone Exp $

EAPI=5
inherit flag-o-matic eutils games git-r3

EGIT_REPO_URI='https://github.com/jamespetts/simutrans-experimental.git'
EGIT_BRANCH=devel-new
EGIT_COMMIT=devel-new

DESCRIPTION="A free Transport Tycoon clone Experimental version."
HOMEPAGE="http://www.simutrans.com/"
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="media-libs/libsdl[sound,video]
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}"
PDEPEND="games-simulation/simutrans-exp-britain-ex
	games-simulation/simutrans-exp-lang"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	strip-flags # bug #293927
	echo "BACKEND=mixer_sdl
COLOUR_DEPTH=16
OSTYPE=linux
FLAGS=-DSTEPS16
MULTI_THREAD=1" > config.default \
	|| die "echo failed"

	if use amd64; then
		echo "FLAGS+=-DUSE_C" >> config.default
	fi

	if use debug; then
		echo "DEBUG=3" >> config.default
	else
		echo "OPTIMISE=1" >> config.default
	fi

	# make it look in the install location for the data
	sed -i \
		-e "s:argv\[0\]:\"${GAMES_DATADIR}/${PN}/\":" \
		simmain.cc \
		|| die "sed failed"

	# Please don't override our CFLAGS, kthx
	sed -i \
		-e '/-O$/d' \
		Makefile \
		|| die "sed failed"

	rm -f simutrans/simutrans
	epatch "${FILESDIR}"/${PN}-0.102.2.2-gcc46.patch
}

src_compile() {
	emake
	cd makeobj ; emake
}

src_install() {
	newgamesbin build/default/simutrans-experimental ${PN} || die "dogamesbin failed"

	exeinto /usr/lib/games/${PN}
	doexe build/default/makeobj/makeobj || die "doexe failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r simutrans/* || die "doins failed"
	dodoc documentation/* todo.txt
	doicon simutrans.ico
	make_desktop_entry simutrans Simutrans /usr/share/pixmaps/simutrans.ico
	prepgamesdirs
}
