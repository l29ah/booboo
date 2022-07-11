# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A simple AIS tuner and generic dual-frequency FM demodulator"
HOMEPAGE="https://github.com/dgiardini/rtl-ais"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dgiardini/${PN}.git"
	KEYWORDS=""
else
	KEYWORDS="~arm ~amd64 ~x86"
	SRC_URI="https://github.com/dgiardini/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="net-wireless/rtl-sdr
		virtual/libusb:1"
DEPEND="${RDEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" \
		UNAME="Linux"
		CFLAGS="$($(tc-getPKG_CONFIG) --cflags librtlsdr) ${CFLAGS}" \
		LIBS="${LDFLAGS} $($(tc-getPKG_CONFIG) --libs librtlsdr) -lm -lpthread"
}
src_install() {
	dobin rtl_ais
}
