# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="4X Space Strategy game"
HOMEPAGE="https://github.com/BlindMindStudios/StarRuler2-Source"
EGIT_REPO_URI="https://github.com/BlindMindStudios/StarRuler2-Source"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	virtual/opengl
	virtual/glu
	media-libs/openal
	media-libs/libpng:0
	sys-libs/zlib
	media-libs/glew:=
	media-libs/freetype
	>=media-libs/libvorbis-1.1.2
	>=media-libs/libogg-1.1.3
	app-arch/bzip2
	x11-libs/libXrandr
	net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# spew
	sed -i -e 's,^	@,	,' source/linux/Makefile

	# we know better
	sed -i -e 's#-m64 -march=athlon64 -mtune=generic##g' source/*/Makefile source/*/*/Makefile source/linux/build.sh

	default
}

src_compile() {
	# FIXME
	export LDFLAGS="$LDFLAGS -Wl,--no-as-needed"

	emake -f source/linux/Makefile compile
}
