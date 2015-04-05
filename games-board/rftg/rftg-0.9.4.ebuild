# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games autotools

DESCRIPTION="\"Race for the Galaxy\" card game."
HOMEPAGE="http://keldon.net/rftg/"
SRC_URI="http://keldon.net/rftg/rftg-0.9.4.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_prepare()
{
	eautoreconf
}

src_compile()
{
	games_src_compile
}

src_install()
{
	emake DESTDIR="${D}" install || die
}

