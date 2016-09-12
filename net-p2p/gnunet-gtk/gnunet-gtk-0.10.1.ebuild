# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

SRC_URI="mirror://gnu/gnunet/${P}.tar.gz"
KEYWORDS="~amd64"

AUTOTOOLS_IN_SOURCE_BUILD=1

DESCRIPTION="GNUnet is a framework for secure peer-to-peer networking."
HOMEPAGE="http://gnunet.org/"
RESTRICT="test"

LICENSE="GPL-3"

SLOT="0"
IUSE="gtk2"

DEPEND="
	net-p2p/gnunet
	>=dev-util/glade-3.10.0
	gtk2? ( x11-libs/gtk+:2 )
	!gtk2? ( x11-libs/gtk+:3 )"
RDEPEND="net-p2p/gnunet"

src_configure() {
	econf \
			$(use_with gtk2 gtk-version=2.0.0)
}
