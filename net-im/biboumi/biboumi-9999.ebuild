# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils user

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://lab.louiz.org/louiz/biboumi.git"
else
	KEYWORDS="~x86 ~amd64"
	SRC_URI="http://git.louiz.org/biboumi/snapshot/${P}.tar.xz"
fi

DESCRIPTION="XMPP gateway to IRC."
HOMEPAGE="http://biboumi.louiz.org/"

LICENSE="ZLIB"
SLOT="0"
IUSE="doc +tls systemd +litesql"

RDEPEND="
	dev-libs/expat
	virtual/libiconv
	sys-apps/util-linux
	net-dns/libidn
	net-dns/c-ares
	tls? ( >=dev-libs/botan-1.11 )
	litesql? ( dev-cpp/litesql )"
DEPEND="${RDEPEND}
	doc? ( app-text/pandoc )"

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
