# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.4.ebuild,v 1.2 2014/12/11 07:32:54 radhermit Exp $

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="The C preprocessor chainsaw"
HOMEPAGE="http://coan2.sourceforge.net/"
EGIT_REPO_URI="git://git.code.sf.net/p/coan2/git_code"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

src_prepare() {
	eautoreconf
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
