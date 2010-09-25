# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base mercurial

DESCRIPTION="Simple generic tabbed fronted to xembed aware applications"
HOMEPAGE="http://tools.suckless.org/tabbed"
EHG_REPO_URI='http://hg.suckless.org/tabbed'

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

S="$WORKDIR/$PN"

src_prepare() {
	sed -i -e '/^PREFIX/s/local//;
			   /^CFLAGS/s/=/+=/;
			   /^LDFLAGS/s/=/+=/' config.mk
}
