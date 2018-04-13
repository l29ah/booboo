# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 user systemd cmake-utils

DESCRIPTION="Encrypted P2P, messaging, and audio/video calling platform"
HOMEPAGE="https://tox.chat"
SRC_URI=""
EGIT_REPO_URI="https://github.com/TokTok/c-toxcore.git"

LICENSE="GPL-3+"
SLOT="0/0.1"
KEYWORDS=""
IUSE="+av daemon static-libs"

RDEPEND="
	av? ( media-libs/libvpx:=
		media-libs/opus )
	daemon? ( dev-libs/libconfig )
	>=dev-libs/libsodium-0.6.1:=[asm,urandom]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
	-DBOOTSTRAP_DAEMON=$(usex daemon ON OFF)
	-DBUILD_TOXAV=$(usex av ON OFF)
	-DENABLE_STATIC=$(usex static-libs ON OFF)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use daemon; then
		newinitd "${FILESDIR}"/initd tox-dht-daemon
		newconfd "${FILESDIR}"/confd tox-dht-daemon
		insinto /etc
		doins "${FILESDIR}"/tox-bootstrapd.conf
		systemd_dounit "${FILESDIR}"/tox-bootstrapd.service
	fi

	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	if use daemon; then
		enewgroup ${PN}
		enewuser ${PN} -1 -1 -1 ${PN}
		if [[ -f ${EROOT%/}/var/lib/tox-dht-bootstrap/key ]]; then
			ewarn "Backwards compatability with the bootstrap daemon might have been"
			ewarn "broken a while ago. To resolve this issue, REMOVE the following files:"
			ewarn "    ${EROOT%/}/var/lib/tox-dht-bootstrap/key"
			ewarn "    ${EROOT%/}/etc/tox-bootstrapd.conf"
			ewarn "    ${EROOT%/}/run/tox-dht-bootstrap/tox-dht-bootstrap.pid"
			ewarn "Then just re-emerge net-libs/tox"
		fi
	fi
}
