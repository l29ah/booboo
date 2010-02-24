# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libixp/libixp-0.4.ebuild,v 1.1 2007/11/18 05:44:12 omp Exp $

inherit toolchain-funcs

DESCRIPTION="Library for writing 9P2000 compliant user-space file servers that
can be mounted using v9fs file system."
HOMEPAGE="http://sourceforge.net/projects/npfs/"
SRC_URI="mirror://sourceforge/npfs/spfs-0.2.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/spfs/libspfs"

	sed "s#\/usr\/local#${D}\/usr#; s#cp#cp -P#" Makefile -i
}

src_compile() {
	cd "${WORKDIR}/spfs/libspfs"
	emake || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/spfs/libspfs"
	# I WANT DOHEADER!!
	mkdir -p "${D}/usr/include"
	cp "../include/spfs.h" "${D}/usr/include"
	dolib libspfs.a
}
