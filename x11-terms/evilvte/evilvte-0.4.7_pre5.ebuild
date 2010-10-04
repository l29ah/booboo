# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/evilvte/evilvte-0.4.6.ebuild,v 1.3 2010/06/20 10:13:04 hwoarang Exp $

EAPI=2
inherit toolchain-funcs savedconfig

DESCRIPTION="VTE based, super lightweight terminal emulator"
HOMEPAGE="http://www.calno.com/evilvte"
MY_P="$PN-${PV/_/~}"
SRC_URI="http://www.calno.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/vte
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="$WORKDIR/$MY_P"

src_prepare() {
	if use savedconfig; then
		restore_config src/config.h
	fi
}

src_configure() {
	tc-export CC
	./configure --prefix=/usr || die
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
	save_config src/config.h
}
