# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dillo/dillo-9999.ebuild,v 1.2 2009/04/17 15:11:02 yngwin Exp $

EAPI="2"
inherit eutils mercurial

DESCRIPTION="drawterm – connect to Plan 9 CPU servers from other operating
systems"
HOMEPAGE="http://swtch.com/drawterm/"
EHG_REPO_URI="http://code.swtch.com/drawterm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	emake CONF=unix || die "make failed"
}

src_install() {
	dodir /usr/bin
	mv ${S}/drawterm ${D}/usr/bin/
}
