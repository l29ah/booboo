# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

DESCRIPTION="Miredo is an open-source Teredo IPv6 tunneling software"
HOMEPAGE="http://www.remlab.net/miredo/"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI='https://git.remlab.net/git/miredo.git'
else
	SRC_URI="https://www.remlab.net/files/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+caps"

RDEPEND="sys-apps/iproute2
	dev-libs/judy
	caps? ( sys-libs/libcap )
	acct-user/miredo
	acct-group/miredo"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

CONFIG_CHECK="~IPV6" #318777

#tries to connect to external networks (#339180)
RESTRICT="test"

DOCS=( AUTHORS NEWS README TODO THANKS )

src_prepare() {
	eapply "${FILESDIR}"/${PN}-1.2.5-configure-libcap.diff
	eapply "${FILESDIR}"/${PN}-1.2.5-ip-path.patch
	default
	eautoreconf
	if [[ ${PV} == *9999* ]]; then
		cp "$BROOT/usr/share/gettext/gettext.h" include/
	fi
}

src_configure() {
	econf \
		--disable-static \
		--enable-miredo-user \
		--localstatedir=/var \
		$(use_with caps libcap)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die

	newinitd "${FILESDIR}"/miredo.rc.2 miredo
	newconfd "${FILESDIR}"/miredo.conf.2 miredo
	newinitd "${FILESDIR}"/miredo.rc.2 miredo-server
	newconfd "${FILESDIR}"/miredo.conf.2 miredo-server

	insinto /etc/miredo
	doins misc/miredo-server.conf
}
