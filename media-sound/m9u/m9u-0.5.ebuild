# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="m9u is designed to be a music server, much like mpd or xmms2. It sits in the background playing music, exporting an interface that one or more clients can connect to to control playback."
HOMEPAGE="http://sqweek.dnsdojo.org/code/m9u/"
SRC_URI="http://sqweek.net/9p/$P.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/libixp-0.5"
RDEPEND="$DEPEND"

src_prepare() {
	# Support never versions of libixp
	sed -i -e 's#^\(CFLAGS=.*\)$#\1 -DIXP_NEEDAPI=126#' Makefile
}

src_install() {
	einstall
}
