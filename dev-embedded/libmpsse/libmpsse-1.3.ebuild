# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Open source library for SPI/I2C control via FTDI chips"
HOMEPAGE="https://code.google.com/p/libmpsse"
SRC_URI="https://libmpsse.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-embedded/libftdi"
RDEPEND="${DEPEND}"

S="$S/src"
