# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit base

DESCRIPTION="crosstool-NG aims at building toolchains."
HOMEPAGE="http://crosstool-ng.org/"
SRC_URI="http://crosstool-ng.org/download/crosstool-ng/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	epatch "$FILESDIR/crosstool-ng-1.17.0-purge-absolute-path-check.patch"
	base_src_install
}
