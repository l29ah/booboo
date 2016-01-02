# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils git-r3 multilib eutils

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
EGIT_REPO_URI="https://github.com/cliffordwolf/yosys.git"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sys-libs/readline
	virtual/libffi
	dev-vcs/git
	dev-lang/tcl
	dev-vcs/mercurial"

DEPEND="
	sys-devel/bison
	sys-devel/flex
	>=dev-lang/python-3
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-path-fix.patch
}

src_configure() {
	emake config-gcc
}

