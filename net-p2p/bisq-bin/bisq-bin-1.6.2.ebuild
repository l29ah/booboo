EAPI=7

inherit desktop eutils unpacker xdg-utils

DESCRIPTION="The decentralized bitcoin exchange (non-atomic, with arbitration)"
HOMEPAGE="https://bisq.network/ https://github.com/bisq-network/exchange/"
SRC_URI="https://bisq.network/downloads/v${PV}/Bisq-64bit-${PV}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-java/openjfx
	net-libs/libnet
	virtual/jre
	x11-libs/gtk+:2"

RESTRICT="mirror strip"

# Bundled java, and seems to mostly work without an old ffmpeg
QA_PREBUILT="opt/Bisq/Bisq opt/Bisq/libpackager.so opt/Bisq/runtime/*"
REQUIRES_EXCLUDE="libgstreamer-lite.so libavplugin-53.so libavplugin-54.so libavplugin-55.so libavplugin-56.so libavplugin-57.so libavplugin-ffmpeg-56.so libavplugin-ffmpeg-57.so"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_compile() {
	:
}

src_install() {
	dodir /opt
	cp -ar "${S}"/opt/Bisq "${ED}"/opt/
	dosym ../Bisq/Bisq /opt/bin/Bisq
	domenu opt/Bisq/Bisq.desktop
	doicon opt/Bisq/Bisq.png
}
