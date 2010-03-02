# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-4.0.ebuild,v 1.8 2009/12/07 23:01:46 vapier Exp $

inherit toolchain-funcs eutils

MY_PV=${PV}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz
		lzma? ( mirror://sourceforge/sevenzip/lzma465.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="+lzma"

RDEPEND="sys-libs/zlib"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use lzma ; then
		EPATCH_OPTS="-p1" epatch "${FILESDIR}/${P}-lzma.patch"
	fi

	sed -i \
		-e 's:-O2:$(CFLAGS):' \
		-e '/-lz/s:$: $(LDFLAGS):' \
		Makefile || die "sed failed"
	sed -i -e 's:get_nprocs():sysconf(_SC_NPROCESSORS_ONLN):' *.c
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better."
}
