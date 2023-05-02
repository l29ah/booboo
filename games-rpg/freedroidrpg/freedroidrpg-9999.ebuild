# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-3 )
PYTHON_COMPAT=( python3_{8..11} )

inherit autotools eutils gnome2-utils lua-single python-any-r1 xdg git-r3

DESCRIPTION="Modification of the classical Freedroid engine into an RPG"
HOMEPAGE="https://www.freedroid.org"
SRC_URI=""
EGIT_REPO_URI="https://gitlab.com/freedroid/freedroid-src.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="debug devtools nls opengl profile sanitize +sound"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	media-libs/libpng:=
	media-libs/libsdl[opengl?,sound?,video]
	>=media-libs/sdl-gfx-2.0.21:=
	media-libs/sdl-image[jpeg,png]
	sys-libs/zlib:=
	devtools? ( media-libs/sdl-ttf )
	nls? ( virtual/libintl )
	opengl? (
		media-libs/glew:0=
		virtual/opengl
	)
	sound? (
		media-libs/libogg
		media-libs/libvorbis
		media-libs/sdl-mixer[vorbis]
	)"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	sanitize? ( || ( sys-devel/gcc[sanitize] sys-devel/clang-runtime[sanitize] ) )"

S="${WORKDIR}/${PN}-${PV}"

pkg_setup() {
	lua-single_pkg_setup
	python-any-r1_pkg_setup
}

src_prepare() {
	default

	python_fix_shebang src/gen_savestruct.py
	rm data/sound/speak.py || die # unused, prevent installing

	eautoreconf
}

src_configure() {
	local econfargs=(
		$(use_enable debug backtrace)
		$(use_enable debug)
		$(use_enable devtools dev-tools)
		$(use_enable nls)
		$(use_enable opengl)
		$(use_enable profile rtprof)
		$(use_enable sound)
		$(use_with debug extra-warnings)
		$(use_enable sanitize sanitize-address)
	)
	econf "${econfargs[@]}"
}

pkg_postinst() {
	xdg_pkg_postinst

	if [[ ${REPLACING_VERSIONS} ]]; then
		local min="1.0_rc1"
		if ver_test ${REPLACING_VERSIONS} -lt ${min}; then
			elog "${P} is not compatible with save games before ${min}."
			elog "Please start a new character."
		fi
	fi
}
