# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="CLI and C library for processing triangulated solid meshes"
HOMEPAGE="https://admesh.readthedocs.io/"
EGIT_REPO_URI="https://github.com/admesh/admesh/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
