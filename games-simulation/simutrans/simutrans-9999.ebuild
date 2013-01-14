# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.102.2.2.ebuild,v 1.5 2012/03/23 20:14:06 tupone Exp $

EAPI=4
inherit flag-o-matic eutils games git

EGIT_REPO_URI='https://github.com/jamespetts/simutrans-experimental.git'
EGIT_BRANCH=devel
EGIT_COMMIT=devel

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.com/"
pak=Pak128.Britain-Ex-0.8.4
SRC_URI="https://github.com/downloads/jamespetts/$PN-pak128.britain/$pak.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libsdl[audio,video]
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	git_src_unpack
	cd "$S"
	unpack $A
}

src_prepare() {
	strip-flags # bug #293927
	echo "BACKEND=mixer_sdl
COLOUR_DEPTH=16
OSTYPE=linux
FLAGS=-DSTEPS16" > config.default \
	|| die "echo failed"

	if use amd64; then
		echo "FLAGS+=-DUSE_C" >> config.default
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
	epatch "${FILESDIR}"/${PN}-0.102.2.2-gcc46.patch \
		"${FILESDIR}"/${P}-zlib.patch
}

src_install() {
	newgamesbin build/default/simutrans-experimental ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r $pak || die "doins failed"
	doins -r simutrans/* || die "doins failed"
	dodoc documentation/* todo.txt
	doicon simutrans.ico
	make_desktop_entry simutrans Simutrans /usr/share/pixmaps/simutrans.ico
	prepgamesdirs
}
