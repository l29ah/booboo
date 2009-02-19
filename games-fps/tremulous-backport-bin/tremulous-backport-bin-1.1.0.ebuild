# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils

DESCRIPTION="Tremulous backport mod"
HOMEPAGE="http://tremulous.tjw.org/backport/"
SRC_URI="http://tremulous.tjw.org/backport/linux/tremulous.x86
http://prdownloads.sourceforge.net/tremulous/tremulous-1.1.0-installer.x86.run?download"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MY_PN=${PN%-backport-bin}

UIDEPEND="virtual/opengl
	x86? (
		media-libs/alsa-lib
		media-libs/openal
		media-libs/libogg
		media-libs/libvorbis
		media-libs/libsdl
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm )
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-medialibs )"
RDEPEND="sdl? ( ${UIDEPEND} )
	!sdl? ( !dedicated? ( ${UIDEPEND} ) )
	sys-libs/glibc
	!games-fps/tremulous"
DEPEND="${RDEPEND}
	app-arch/unzip"

dir=${GAMES_PREFIX_OPT}/${MY_PN}

src_install() {
	insinto "${dir}"
	doins -r base || die "doins -r base failed"
	doins ChangeLog COPYING manual.pdf || die "doins failed"

	# The executables must be in the same tree as the game data
	exeinto "${dir}"
	#if install_client ; then
		# Install client
		newexe ${MY_PN}.x86 ${MY_PN}.bin \
			|| die "newexe ${MY_PN}.x86 failed"
		doicon ${MY_PN}.xpm || die "doicon failed"
		games_make_wrapper ${MY_PN} ./${MY_PN}.bin "${dir}"
		make_desktop_entry ${MY_PN} "Tremulous" ${MY_PN}
	#fi

	#if use dedicated ; then
		# Install server
	#	newexe tremded.x86 ${MY_PN}-ded.bin \
	#		|| die "newexe tremded.x86 failed"
	#	games_make_wrapper ${MY_PN}-ded ./${MY_PN}-ded.bin "${dir}"
	#fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "Read instructions:  http://tremulous.net/manual/"
	elog "or:  ${dir}/manual.pdf"
	echo
}

