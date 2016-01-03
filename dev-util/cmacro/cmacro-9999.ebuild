# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.4.ebuild,v 1.2 2014/12/11 07:32:54 radhermit Exp $

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="cmacro: Lisp macros for C"
HOMEPAGE="https://github.com/eudoxia0/cmacro"
EGIT_REPO_URI="https://github.com/eudoxia0/cmacro.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lisp/sbcl"

DOCS=( README.md )

MAKEOPTS="-j1"

QA_PRESTRIPPED="usr/bin/cmc"
QA_WX_LOAD="usr/bin/cmc"

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
