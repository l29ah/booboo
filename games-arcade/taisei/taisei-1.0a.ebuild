# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils
DESCRIPTION="Taisei (lit. Occident) is a fan-made, Open Source clone of the
Touhou series, written in C using SDL/OpenGL/OpenAL."
HOMEPAGE="http://taisei-project.org/"
SRC_URI="https://github.com/laochailan/taisei/tarball/v1.0a -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/libpng
	virtual/opengl
	media-libs/openal
	media-libs/freealut
	dev-util/cmake
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/laochailan-taisei-2f64a13
