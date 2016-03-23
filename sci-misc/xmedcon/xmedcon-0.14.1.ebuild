# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Medical Image Conversion Utility"
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="primaryuri"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="png gtk"

# Block ebuild versions put in other categories
RDEPEND="gtk? ( x11-libs/gtk+:2 )
		png? ( media-libs/libpng:= )
		!!sci-libs/xmedcon
		!!media-gfx/xmedcon"

DEPEND="$RDEPEND"

src_configure() {

	local myconf="$(use_enable gtk gui) $(use_enable png)"

	econf ${myconf} || die
}

src_install() {

	make DESTDIR="${D}" install || die

	dodoc AUTHORS COPYING* INSTALL NEWS README REMARKS

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins "${S}/etc/xmedcon.png"
}
