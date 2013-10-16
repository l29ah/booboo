# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base git-2

DESCRIPTION="Video bios execution tracing widget"
HOMEPAGE="http://cgit.freedesktop.org/~stuart/vbtracetool/"
EGIT_REPO_URI="git://anongit.freedesktop.org/~stuart/vbtracetool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/gcc/$(CC)/;
			   /^CFLAGS *=/s/=/+=/;' Makefile
}

src_install() {
	dobin vbtracetool
}
