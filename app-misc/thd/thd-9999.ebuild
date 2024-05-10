# Copyright 1999-2024 Your Mom
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="a lightweight hotkey daemon"
HOMEPAGE="https://github.com/wertarbyte/triggerhappy"
EGIT_REPO_URI="https://github.com/wertarbyte/triggerhappy"

SLOT="0"

LICENSE="GPL-3"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	newconfd "${FILESDIR}"/thd.confd thd
	newinitd "${FILESDIR}"/thd.initd thd
	insinto /etc
	newins triggerhappy.conf.examples triggerhappy.conf
}
