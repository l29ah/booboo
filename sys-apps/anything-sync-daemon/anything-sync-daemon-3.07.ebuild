# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/profile-sync-daemon/profile-sync-daemon-3.16.ebuild,v 1.1 2012/10/16 21:48:39 hasufell Exp $

EAPI=4

inherit eutils vcs-snapshot

DESCRIPTION="Symlinks and syncs user specified dirs to RAM thus reducing HDD/SDD calls and speeding-up the system."
HOMEPAGE="https://wiki.archlinux.org/index.php/Anything-sync-daemon"
SRC_URI="http://repo-ck.com/source/${PN}/${P}.tar.xz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-shells/bash
	net-misc/rsync
	virtual/cron"

src_install() {
	install -Dm755 ${PN} "${D}/usr/bin/${PN}"
	install -Dm644 asd.conf "${D}/etc/asd.conf"
	install -Dm755 asd.cron.hourly "${D}/etc/cron.hourly/asd-update"
	install -Dm644 "asd.service" "${D}/usr/lib/systemd/system/asd.service"
	
	gzip -9 asd.manpage
	install -g 0 -o 0 -Dm 0644 asd.manpage.gz "${D}/usr/share/man/man1/${PN}.1.gz"
	install -g 0 -o 0 -Dm 0644 asd.manpage.gz "${D}/usr/share/man/man1/asd.1.gz"

	install -Dm755 ${FILESDIR}/initd "${D}/etc/init.d/asd"
}
