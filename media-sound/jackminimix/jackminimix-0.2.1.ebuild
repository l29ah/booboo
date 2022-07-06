# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a simple mixer for the Jack with an OSC control interface."
HOMEPAGE="https://www.aelius.com/njh/jackminimix/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="https://github.com/njh/${PN}/releases/download/${PV}/${P}.tar.gz"

RDEPEND="virtual/jack
	media-libs/liblo"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS COPYING NEWS README )
