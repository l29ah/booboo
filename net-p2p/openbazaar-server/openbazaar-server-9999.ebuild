# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 user

DESCRIPTION="OpenBazaar is a decentralized marketplace proof of concept. It is based off of the POC code by the darkmarket team and is now licensed under the MIT license."
HOMEPAGE="https://github.com/OpenBazaar/OpenBazaar-Server"
EGIT_REPO_URI="https://github.com/OpenBazaar/OpenBazaar-Server"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-python/ipy-0.82a
	>=dev-python/pillow-2.8.1
	>=dev-python/miniupnpc-1.8
	>=dev-python/psutil-2.2.1
	>=dev-python/bitcoin-1.1.27
	>=dev-python/pycountry-1.10
	>=dev-python/pyelliptic-1.5.5
	>=dev-python/pystun-0.1.0
	>=dev-python/python-gnupg-0.3.7
	>=dev-python/python-obelisk-0.1.3
	>=dev-python/qrcode-5.1
	>=dev-python/requests-2.5.1
	>=www-servers/tornado-4.0.2
	>=dev-python/twisted-core-14.0.2
	>=dev-python/rfc3986-0.2.0
	>=dev-python/dnschain-0.1.0
	>=dev-python/pyee-0.1.0
	dev-python/pylint
	dev-python/nose
	dev-python/txrudp"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser openbazaar
}

src_install() {
	doman docs/openbazaar.1
	dodoc changelog LICENSE.md
	dobin openbazaar
	insinto /usr/share/openbazaar/
	doins -r node html rudp
	dodir /var/log/openbazaar /var/lib/openbazaar
	fowners openbazaar /var/log/openbazaar /var/lib/openbazaar
}
