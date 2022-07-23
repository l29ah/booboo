# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

S="${WORKDIR}/spfs/libspfs"

src_prepare() {
	sed "s#\/usr\/local#${D}\/usr#; s#cp#cp -P#" Makefile -i
	default
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	mkdir -p "${D}/usr/include"
	cp "../include/spfs.h" "${D}/usr/include"
	dolib.a libspfs.a
}
