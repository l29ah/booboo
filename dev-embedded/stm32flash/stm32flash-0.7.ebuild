# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open source flash program for STM32 using the ST serial bootloader"
HOMEPAGE="http://sourceforge.net/projects/stm32flash/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#/usr/local#/usr#g' Makefile

	eapply_user
}
