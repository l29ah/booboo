# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

my_PN="fbset"
my_P=${my_PN}_$(ver_rs 2 -)

DESCRIPTION="Shows and sets mapping between consoles and framebuffer devices"
HOMEPAGE="https://debian.org/"
SRC_URI="mirror://debian/pool/main/f/fbset/${my_P}.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="sys-kernel/linux-headers"

S=$WORKDIR

src_prepare() {
	patch -i debian/patches/03_con2fbmap.patch
	echo 'con2fbmap: con2fbmap.c' > Makefile

	default
}

src_install() {
	dobin con2fbmap
	doman con2fbmap.1
}
