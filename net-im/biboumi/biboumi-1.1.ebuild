# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="XMPP gateway to IRC."
HOMEPAGE="http://biboumi.louiz.org/"
SRC_URI="http://git.louiz.org/biboumi/snapshot/biboumi-1.1.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/expat
	virtual/libiconv
	sys-apps/util-linux
	net-dns/libidn
	net-dns/c-ares
	dev-libs/botan"
RDEPEND="${DEPEND}"
