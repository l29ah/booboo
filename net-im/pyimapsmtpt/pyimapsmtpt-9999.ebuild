# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="An xmpp transport (or bot, possibly to-be-done) that allows using IMAP+SSMTP (e.g. gmail's) from an XMPP client."
HOMEPAGE="https://github.com/HoverHell/pyimapsmtpt"
EGIT_REPO_URI="https://github.com/HoverHell/pyimapsmtpt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/xmpppy
	dev-python/imapclient
	dev-python/gevent
	>=dev-python/html2text-2014.12.29"
