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

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/libpng
	virtual/opengl
	media-libs/openal
	media-libs/freealut
"
RDEPEND="${DEPEND}"
