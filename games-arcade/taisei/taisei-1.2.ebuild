# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit eutils python-r1 gnome2-utils meson xdg-utils

DESCRIPTION="A free and open-source Touhou Project clone and fangame"
HOMEPAGE="http://taisei-project.org/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/taisei-project/taisei"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/taisei-project/taisei/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE="+audio debug static-libs"

RDEPEND="${PYTHON_DEPS}
	audio? ( media-libs/sdl2-mixer[vorbis] )
	dev-libs/libzip
	sys-libs/zlib
	>=media-libs/sdl2-ttf-2.0.5
	media-libs/sdl2-image[jpeg,png]
	media-libs/libpng:0
	media-libs/libsdl
	virtual/opengl
	virtual/jpeg:0"

DEPEND="${RDEPEND}
	>=dev-util/meson-0.45.0
	dev-python/docutils[${PYTHON_USEDEP}]
	virtual/pkgconfig"

src_prepare() {
	# Fix "QA Notice: Pre-stripped files found" and disable installing a COPYRIGHT file
	sed -i \
		-e "s/'strip=true'/'strip=false'/" \
		-e "/subdir('doc')/d" \
		-e "216,217d" \
		meson.build && rm -v doc/meson.build || die "sed failed!"

	if use debug; then
		sed -i \
			-e "s/'buildtype=release'/'buildtype=debug'/" \
			meson.build || die "sed failed!"
	fi

	eapply_user
}

src_configure() {
	local emesonargs=(
		-Denable_audio=$(usex audio true false)
		-Ddebug_opengl=$(usex debug true false)
		-Dstatic=$(usex static-libs true false)
		-Dpackage_data=true
		-Ddocs=false
	)

	if [[ ${PV} != *9999 ]]; then
		emesonargs+=( -Dversion_fallback="${PV}" )
	fi

	meson_src_configure
}

src_install() {
	dodoc -r doc/* README.rst
	meson_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
