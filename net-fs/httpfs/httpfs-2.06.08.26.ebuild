# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Fuse-based httpfs file system"
HOMEPAGE="http://httpfs.sourceforge.net/"
FN="httpfs_with_static_binaries_${PV}"
SRC_URI="https://downloads.sourceforge.net/${PN}/${FN}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND=${DEPEND}

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	# The script doesn't accept custom CFLAGS. Fix it.
	sed -i \
		-e "s:^gcc -c -O2 -g -Wall \(.*\)$:$(tc-getCC) -c ${CFLAGS} \1:" \
		-e "s:^gcc -s \(.*\):$(tc-getCC) ${CFLAGS} \1:" \
		make_httpfs || die "sed make_httpfs failed"
	# Remove shipped binaries
	find . -name httpfs -delete
}

src_compile() {
	./make_httpfs || die "make_httpfs failed"
}

src_install() {
	dobin httpfs
	newdoc readme.2 readme
}
