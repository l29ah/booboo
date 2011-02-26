# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A bunch of symlinks to /usr/src/linux"
HOMEPAGE=""
SRC_URI=""

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	cd $D
	mkdir -p usr/include
	cd usr/include
	ln -s /usr/src/linux/include/video/ .
	ln -s /usr/src/linux/include/xen .
	ln -s /usr/src/linux/include/rdma/ .
	ln -s /usr/src/linux/arch/x86/include/asm/ .
	ln -s /usr/src/linux/include/mtd/ .
	ln -s /usr/src/linux/include/linux/ .
	ln -s /usr/src/linux/include/linux/ .
	ln -s /usr/src/linux/include/asm-generic/ .
}
