# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="734ef305c472b5c3a197e9a3673fba66c335fa44"
DLG_COMMIT="72dfcc858c040c54a6a0b88fcb7e70ee186d3167"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mryndzionek/sdr_pmr446"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="
		https://github.com/mryndzionek/sdr_pmr446/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
		https://github.com/nyorain/dlg/archive/${DLG_COMMIT}.tar.gz -> dlg-${DLG_COMMIT}.tar.gz
	"
	S="${WORKDIR}/sdr_pmr446-${COMMIT}"
fi

DESCRIPTION="Simple PMR446 scanner"
HOMEPAGE="https://github.com/mryndzionek/sdr_pmr446"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-wireless/soapysdr:=
	net-libs/liquid-dsp:=
	media-libs/rtaudio:=
	"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	cd "${S}" || die
	mkdir dependencies
	mv ../dlg-* dependencies/dlg
}

src_prepare() {
	cmake_src_prepare
	sed -i -e '/^link_directories/d' CMakeLists.txt # insecure RUNPATHs
}

src_install() {
	cd "${BUILD_DIR}" || die
	dobin sdr_pmr446 dsd_in
}
