# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 git-2

DESCRIPTION="notifmail is an email daemon checker which notifies system about new emails on configured IMAP servers."
HOMEPAGE="https://github.com/agherzan/notifymail"
EGIT_REPO_URI="https://github.com/agherzan/notifymail"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/python-daemon
	dev-python/notify2
	dev-python/pycrypto"
RDEPEND="${DEPEND}"
