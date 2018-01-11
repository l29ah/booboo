# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit git-r3 distutils-r1

DESCRIPTION="Pomf.se clone uploading tool"
HOMEPAGE="https://github.com/lich/limf"
EGIT_REPO_URI="https://github.com/lich/limf"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
