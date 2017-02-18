# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils git-r3

EGIT_REPO_URI='https://github.com/jamespetts/simutrans-pak128.britain.git'

DESCRIPTION="Britain pakset for Simutrans Extended"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI=""

LICENSE="Artistic"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="=games-simulation/simutrans-extended-9999"
RDEPEND=""

src_compile()
{
	mkdir destdir
	emake MAKEOBJ=/usr/libexec/simutrans-extended-9999/makeobj-extended DESTDIR=destdir
}

src_install()
{
	insinto /usr/share/simutrans-extended-9999
	cd destdir
	doins -r pak128.Britain-Ex || die "doins failed"
}

