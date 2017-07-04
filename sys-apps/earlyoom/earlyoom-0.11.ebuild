# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd

DESCRIPTION="Early OOM Daemon for Linux"
HOMEPAGE="https://github.com/rfjakob/earlyoom"
SRC_URI="https://github.com/rfjakob/earlyoom/archive/v$PV.tar.gz -> $P.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+openrc systemd"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake earlyoom
}

src_install() {
	dobin earlyoom
	use openrc && doinitd "$FILESDIR/$PN"
	use systemd && systemd_dounit earlyoom.service
}
