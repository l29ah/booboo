# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3

EGIT_REPO_URI='https://github.com/VictorErik/Pak128.Sweden-Ex.git'
EGIT_BRANCH=half-height
EGIT_COMMIT=half-height

DESCRIPTION="Sweden pakset for Simutrans Experimental"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="games-simulation/simutrans-exp"
RDEPEND=""

src_compile()
{
	mkdir destdir
	emake MAKEOBJ=/usr/libexec/simutrans-exp-9999/makeobj-experimental DESTDIR=destdir
}

src_install()
{
	insinto /usr/share/simutrans-exp-9999
	cd destdir
	doins -r pak128.Sweden-Ex || die "doins failed"
}

