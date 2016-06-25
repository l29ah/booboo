# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libixp/libixp-0.4.ebuild,v 1.1 2007/11/18 05:44:12 omp Exp $

EAPI=6

DESCRIPTION="libspfs-based daemon that shares the local filesystem over 9P"
HOMEPAGE="http://sourceforge.net/projects/npfs/"
SRC_URI="mirror://sourceforge/npfs/spfs-0.2.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/libspfs"
RDEPEND="sys-libs/libspfs"

S="${WORKDIR}/spfs/fs"

src_prepare() {
	sed 's#: \.\.[^ ]*#:#' Makefile -i || die
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ufs
}
