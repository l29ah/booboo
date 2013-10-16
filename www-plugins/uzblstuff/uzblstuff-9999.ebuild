# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base git-2

DESCRIPTION="uzbl event manager and tab manager and cookie manager"
HOMEPAGE="http://github.com/jakeprobst/uzblstuff"
EGIT_REPO_URI="http://github.com/jakeprobst/uzblstuff.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/gtk+:2
		dev-libs/libxdg-basedir"
RDEPEND="${DEPEND}"

S="$WORKDIR/$PN"

src_prepare() {
	sed -i -e '/^CXX = /d;
			   s/-ggdb//;
			   s/CXXFLAGS =/CXXFLAGS +=/;' Makefile
}

src_install() {
	# uzbltab is no longer maintained and may not even work
	dobin uzblcookied uzblem uzbltreetab
	dodoc ChangeLog README uzbl-browser
}
