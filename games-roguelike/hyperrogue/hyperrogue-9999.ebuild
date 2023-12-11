# Copyright 1999-2022 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3
EGIT_REPO_URI="https://github.com/zenorogue/hyperrogue/"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="A puzzle roguelike in the hyperbolic plane."
HOMEPAGE="https://github.com/zenorogue/hyperrogue/"

LICENSE="GPL-2"
SLOT="0"

IUSE="+glew +png"

RDEPEND="
	media-libs/sdl-gfx
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	glew? ( media-libs/glew )
	png? ( media-libs/libpng )
"

DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i 's#HYPERPATH ""#HYPERPATH "/usr/share/hyperrogue/"#' sysconfig.h
}

src_compile() {
	use glew && export HYPERROGUE_USE_GLEW=1
	use png && export HYPERROGUE_USE_PNG=1
	emake mymake
	./mymake
}

src_install() {
	newbin hyper hyperrogue
	dodir /usr/share/hyperrogue
	insinto /usr/share/hyperrogue
	doins -r sounds
	doins -r music
	doins hyperrogue-music.txt
	doins DejaVuSans-Bold.ttf
}

