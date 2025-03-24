# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/admesh/admesh/"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/admesh/admesh/releases/download/v${PV}/${P}.tar.gz"
fi

DESCRIPTION="CLI and C library for processing triangulated solid meshes"
HOMEPAGE="https://admesh.readthedocs.io/"

LICENSE="GPL-2"
SLOT="0"
