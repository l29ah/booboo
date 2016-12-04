# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Enables legacy applications to leverage Linux's memory deduplication."
HOMEPAGE="http://vleu.net/ksm_preload/"
EGIT_REPO_URI="https://github.com/unbrice/ksm_preload"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""
