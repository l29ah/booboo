# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit mercurial

DESCRIPTION=""
HOMEPAGE="http://go9p.googlecode.com/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

EHG_REPO_URI="https://${PN}.googlecode.com/hg/"

src_unpack() {
	mercurial_src_unpack
}

src_prepare() {
	cd hg
	epatch ${FILESDIR}/fix-once.patch
}

src_install() {
	cd hg
	emake -j1 DESTDIR="${D}" || die "emake failed"
}
