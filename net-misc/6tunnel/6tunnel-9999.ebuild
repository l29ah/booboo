# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 autotools

DESCRIPTION="TCP proxy for applications that don't speak IPv6"
HOMEPAGE="http://toxygen.net/6tunnel"
EGIT_REPO_URI='https://github.com/wojtekka/6tunnel'

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/automake:1.14"

src_prepare() {
	eautoreconf
}

src_install() {
	default
	doman 6tunnel.1
}
