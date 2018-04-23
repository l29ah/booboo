# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils user

DESCRIPTION="XMPP gateway to IRC."
HOMEPAGE="http://biboumi.louiz.org/"
SRC_URI="http://git.louiz.org/biboumi/snapshot/${P}.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+doc +tls systemd"

RDEPEND="
	dev-libs/expat
	virtual/libiconv
	sys-apps/util-linux
	net-dns/libidn
	net-dns/c-ares
	tls? ( >=dev-libs/botan-1.11:= )"
DEPEND="${RDEPEND}
	doc? ( app-text/ronn )"

DOCS=( README.rst CHANGELOG.rst )

pkg_setup() {
	enewuser $PN
}

src_install() {
	dodir /var/log/biboumi
	fowners biboumi /var/log/biboumi
	doinitd "$FILESDIR/biboumi"

	cmake-utils_src_install

	use systemd || rm -rf "$D/usr/lib/systemd"
}
