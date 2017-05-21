# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.13.ebuild,v 1.2 2010/04/06 21:18:47 mr_bones_ Exp $

EAPI=5
inherit cmake-utils eutils games mercurial

DESCRIPTION="Free Worms-like turn based strategy game"
HOMEPAGE="http://hedgewars.org/"
EHG_REPO_URI='http://hg.hedgewars.org/hedgewars/'

LICENSE="GPL-2 Apache-2.0 FDL-1.3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtgui:4
	media-libs/libsdl2[sound,opengl,video]
	media-libs/sdl2-ttf
	media-libs/sdl2-mixer[vorbis]
	media-libs/sdl2-image[png]
	media-libs/sdl2-net
	dev-lang/lua
	>=media-fonts/dejavu-2.28"
DEPEND="${RDEPEND}
	>=dev-lang/fpc-2.2"

src_configure() {
	local mycmakeargs=(
		-DMINIMAL_FLAGS=ON
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DDATA_INSTALL_DIR="${GAMES_DATADIR}/${PN}"
		-Dtarget_binary_install_dir="${GAMES_BINDIR}"
		-Dtarget_library_install_dir="$(games_get_libdir)"
		-DNOSERVER=TRUE
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DPHYSFS_SYSTEM=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="ChangeLog.txt README" cmake-utils_src_install
	rm -f "${D}"/usr/share/games/hedgewars/Data/Fonts/DejaVuSans-Bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf \
		"${GAMES_DATADIR}"/hedgewars/Data/Fonts/DejaVuSans-Bold.ttf
	newicon QTfrontend/res/hh25x25.png ${PN}.png
	make_desktop_entry ${PN} Hedgewars
	doman man/${PN}.6
	prepgamesdirs
}
