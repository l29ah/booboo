# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://git.matrix.org/git/olm/about/"

inherit cmake-multilib

if [[ ${PV} != "9999" ]]; then
	KEYWORDS="~amd64 ~x86"
fi

SRC_URI="https://git.matrix.org/git/${PN}/snapshot/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
