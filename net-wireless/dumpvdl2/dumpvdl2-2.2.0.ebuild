# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A lightweight, standalone VDL Mode 2 message decoder and protocol analyzer"
HOMEPAGE="https://github.com/szpajder/dumpvdl2"
SRC_URI="https://github.com/szpajder/dumpvdl2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtlsdr mirisdr sdrplay"

DEPEND="
	net-wireless/libacars
	rtlsdr? ( net-wireless/rtl-sdr )
	mirisdr? ( net-libs/libmirisdr )
	sdrplay? ( net-wireless/sdrplay )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_RTLSDR=$(usex rtlsdr)
		-DWITH_MIRISDR=$(usex mirisdr)
		-DWITH_SDRPLAY=$(usex sdrplay)
	)

	cmake_src_configure
}
