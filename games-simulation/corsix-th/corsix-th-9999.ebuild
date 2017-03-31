# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
inherit eutils cmake-utils gnome2-utils versionator multilib git-r3

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="https://github.com/CorsixTH/CorsixTH"
EGIT_REPO_URI="https://github.com/CorsixTH/CorsixTH"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="-libav midi +sound truetype"

RDEPEND=">=dev-lang/lua-5.1:0
	media-libs/libsdl2[X,opengl]
	dev-lua/luafilesystem
	dev-lua/lpeg
	dev-lua/luasocket
	virtual/opengl
	midi? ( media-sound/timidity++ )
	!libav? ( media-video/ffmpeg:0= )
	libav? ( media-video/libav:0= )
	sound? ( media-libs/sdl2-mixer )
	truetype? ( media-libs/freetype:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with sound AUDIO)
		$(cmake-utils_use_with truetype FREETYPE2)
		$(cmake-utils_use_with libav LIBAV)
		-DCMAKE_INSTALL_PREFIX=/usr/share/games
		-DWITH_MOVIES="ON"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="CorsixTH/changelog.txt" cmake-utils_src_install
	newicon -s scalable CorsixTH/Original_Logo.svg "${PN}.svg"
	make_wrapper "${PN}" /usr/share/games/CorsixTH/CorsixTH
	make_desktop_entry "${PN}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
