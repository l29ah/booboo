# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="an open-source software-defined GNSS receiver"
HOMEPAGE="https://github.com/gnss-sdr/gnss-sdr"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gnss-sdr/gnss-sdr"
	EGIT_BRANCH="next"
else
	SRC_URI="https://github.com/gnss-sdr/gnss-sdr/archive/refs/tags/v${PV}.tar.gz -> $P.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+osmosdr"

DEPEND="
	osmosdr? ( net-wireless/gr-osmosdr )
	dev-libs/boost:=
	dev-libs/log4cpp:=
	net-wireless/gnuradio:=[zeromq]
	net-libs/libpcap:=
	dev-libs/pugixml:=
	sci-libs/matio:=
	sci-libs/volk:=
	dev-libs/protobuf:=
	sci-libs/armadillo:="
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/fixup-docs.patch"
	"${FILESDIR}/protobuf.patch"
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_UNIT_TESTING=0
		-DENABLE_OSMOSDR=$(usex osmosdr)
	)
	cmake_src_configure
}
