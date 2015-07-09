# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Configuration Access Library"
HOMEPAGE="https://github.com/community-ssu/libcal/"
EGIT_REPO_URI="https://github.com/community-ssu/libcal/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

CFLAGS="$CFLAGS -fPIC"
