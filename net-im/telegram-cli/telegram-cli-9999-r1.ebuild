# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3
EGIT_REPO_URI="https://github.com/vysheng/tg.git"

IUSE="lua"
DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/vysheng/tg"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	dev-libs/openssl
	dev-libs/jansson
	lua? ( dev-lang/lua )"

src_prepare() {
	sed -i -e 's,-Werror,,g' Makefile.in || die
}

src_configure() {
	econf $(use_enable lua liblua ) --with-progname=telegram-cli
}

src_install() {
	dobin bin/telegram-cli
	insinto /etc/telegram-cli/
	newins tg-server.pub server.pub
}
