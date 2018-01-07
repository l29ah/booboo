# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit meson git-r3
DESCRIPTION="Taisei (lit. Occident) is a fan-made, Open Source clone of the
Touhou series, written in C using SDL/OpenGL/OpenAL."
HOMEPAGE="http://taisei-project.org/"
EGIT_REPO_URI="https://github.com/laochailan/taisei"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=media-libs/libsdl2-2.0.5
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	>=dev-libs/libzip-1.0
	>=media-libs/libpng-1.5.0
	virtual/opengl
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	# do not strip as pm will do it for us
	sed -i -e '/strip=true/d' meson.build
}
