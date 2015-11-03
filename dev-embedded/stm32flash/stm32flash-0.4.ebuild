# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Open source flash program for STM32 using the ST serial bootloader"
HOMEPAGE="http://sourceforge.net/projects/stm32flash/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="$WORKDIR/$PN"

src_prepare() {
	sed -i -e 's#/usr/local#/usr#g' Makefile
}
