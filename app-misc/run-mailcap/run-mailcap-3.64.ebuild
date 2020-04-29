# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Run a program specified in the mailcap file based on a mime type"
HOMEPAGE="https://salsa.debian.org/debian/mime-support"
SRC_URI="http://deb.debian.org/debian/pool/main/m/mime-support/mime-support_${PV}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/perl"
BDEPEND=""

S="$WORKDIR/mime-support"

src_install() {
	dobin run-mailcap
}
