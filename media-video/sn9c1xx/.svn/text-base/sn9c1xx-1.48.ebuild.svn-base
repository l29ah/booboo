# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="A driver for sn9c1xx (webcam) devices, like the Sweex Mini cam"
HOMEPAGE="http://www.linux-projects.org/modules/mydownloads/viewcat.php?op=&cid=2"
SRC_URI="http://dev.gentooexperimental.org/~dreeevil/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="VIDEO_DEV USB"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-kbuild.patch
	set_arch_to_kernel
}

src_compile() {
	emake clean || die "emake clean failed"
	emake modules || die "emake modules failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog sn9c102.txt || die "installing docs faild"
}
