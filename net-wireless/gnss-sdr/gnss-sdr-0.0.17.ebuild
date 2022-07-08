# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="an open-source software-defined GNSS receiver"
HOMEPAGE="https://github.com/gnss-sdr/gnss-sdr"
SRC_URI="https://github.com/gnss-sdr/gnss-sdr/archive/refs/tags/v${PV}.tar.gz -> $P.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+osmosdr"

DEPEND="
	osmosdr? ( net-wireless/gr-osmosdr )
	dev-libs/boost:=
	dev-libs/log4cpp:=
	net-wireless/gnuradio:=
	net-libs/libpcap:=
	dev-libs/pugixml:=
	sci-libs/matio:=
	dev-cpp/gflags:=
	sci-libs/volk:=
	dev-cpp/glog:=
	sci-libs/armadillo:="
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DENABLE_UNIT_TESTING=0
		-DENABLE_OSMOSDR=$(usex osmosdr)
	)
	cmake-utils_src_configure
}
