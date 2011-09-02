# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/evilvte/evilvte-0.4.9_pre4.ebuild,v 1.1 2011/07/09 07:14:29 ssuominen Exp $

EAPI=4
MY_P=${P/_/\~}
inherit toolchain-funcs savedconfig

DESCRIPTION="VTE based, super lightweight terminal emulator"
HOMEPAGE="http://www.calno.com/evilvte"
SRC_URI="http://www.calno.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/vte:2.90
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use savedconfig; then
		restore_config src/config.h
	fi
}

src_configure() {
	tc-export CC
	./configure --prefix=/usr --with-gtk=3.0 || die
}

src_compile() {
	emake -j1 || die
}

src_install() {
	default
	save_config src/config.h
}
