# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools git-r3

DESCRIPTION="\"Race for the Galaxy\" card game."
HOMEPAGE="http://keldon.net/rftg/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/bnordli/rftg.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="server"

DEPEND="x11-libs/gtk+:2
	server? (
		virtual/libmysqlclient
	)"
RDEPEND="${DEPEND}"



src_prepare()
{
	eapply_user
	
	S=${S}/src
	cd src
	eautoreconf
}

src_configure()
{
	econf $(use_enable server) || die
}

src_compile()
{
	emake || die
}

src_install()
{
	emake DESTDIR="${D}" install || die
	if use server ; then
		dodoc ../sql/server-schema.sql
	fi
}

