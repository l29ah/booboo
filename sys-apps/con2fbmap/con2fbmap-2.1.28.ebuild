# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Shows and sets mapping between consoles and framebuffer devices"
HOMEPAGE="https://debian.org/"
SRC_URI="http://ftp.lanet.kr/debian/pool/main/f/fbset/fbset_2.1-28.debian.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="sys-kernel/linux-headers"
RDEPEND="${DEPEND}"
BDEPEND=""

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
