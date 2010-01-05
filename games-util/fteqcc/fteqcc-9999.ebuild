# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="QC compiler"
HOMEPAGE="http://fteqw.sourceforge.net/"
ESVN_REPO_URI="https://fteqw.svn.sourceforge.net/svnroot/fteqw/trunk/engine/qclib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/unzip
	dev-util/subversion"
RDEPEND=""

src_unpack() {
	subversion_src_unpack

	edos2unix readme.txt
}

src_compile() {
	emake || die "emake qcc failed"
}

src_install() {
	newbin fteqcc.bin fteqcc || die "newbin fteqcc.bin failed"
	dodoc readme.txt
}
