# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Baresip is a portable and modular SIP User-Agent with audio and video support."
HOMEPAGE="http://creytiv.com/baresip.html"
EGIT_REPO_URI="https://github.com/alfredh/baresip.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	net-voip/re
	>=media-libs/rem-0.4.7"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#/usr/local#/usr#g' Makefile
}
