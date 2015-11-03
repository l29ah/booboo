# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit mercurial

DESCRIPTION="Serial programmer for STM32 that uses the built in bootloader's USART protocol."
HOMEPAGE="https://code.google.com/p/stm32sprog/"
EHG_REPO_URI="https://code.google.com/p/stm32sprog/"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin stm32sprog
	dodoc README
}
