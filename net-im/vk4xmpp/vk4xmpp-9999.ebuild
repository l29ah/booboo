# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 pypy )

inherit python-single-r1 git-r3 user

DESCRIPTION="A jabber transport for VK"
HOMEPAGE="https://github.com/mrDoctorWho/vk4xmpp"
EGIT_REPO_URI="https://github.com/mrDoctorWho/vk4xmpp"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/xmpppy[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	>=dev-python/html2text-2014.12.29[${PYTHON_USEDEP}]"

pkg_setup() {
	enewuser vk4xmpp
	python-single-r1_pkg_setup
}

src_install() {
	insinto "$(python_get_sitedir)/vk4xmpp"
	doins -r gateway.py extensions locales library vk4xmpp.png js gateway.py
	sed -i -e 's#vk4xmpp\.log#/var/log/&#;s#vk4xmpp\.pid#/run/vk4xmpp/&#;s#vk4xmpp\.sqlite#/var/lib/vk4xmpp/&#' Config_example.txt
	dodoc Config_example.txt extensions.README.md LICENSE README.md
	insinto /etc
	newins Config_example.txt vk4xmpp

	touch vk4xmpp.log
	insinto /var/log
	doins vk4xmpp.log
	fowners vk4xmpp /var/log/vk4xmpp.log

	keepdir /run/vk4xmpp
	fowners vk4xmpp /run/vk4xmpp

	keepdir /var/lib/vk4xmpp
	fowners vk4xmpp /var/lib/vk4xmpp

	doinitd "$FILESDIR/$PN-init.d"
}
