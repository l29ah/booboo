# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="A lightweight C++11 Distributed Hash Table implementation originally based on https://github.com/jech/dht by Juliusz Chroboczek."
HOMEPAGE="https://github.com/savoirfairelinux/opendht/"
EGIT_REPO_URI="https://github.com/savoirfairelinux/opendht/"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/msgpack[cxx]"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}
