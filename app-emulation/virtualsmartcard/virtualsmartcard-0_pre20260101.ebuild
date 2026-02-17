# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

COMMIT="a85862856ef0f7b521c5bf320e69683399ccc4fc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/frankmorgner/vsmartcard"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/frankmorgner/vsmartcard/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/vsmartcard-${COMMIT}/${PN}"
fi

DESCRIPTION="Virtual Smart Card"
HOMEPAGE="https://frankmorgner.github.io/vsmartcard/virtualsmartcard/README.html"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		--enable-serialconfdir=/etc/reader.conf.d \
		--enable-serialdropdir=$(pkg-config libpcsclite --variable=usbdropdir)/serial
}
