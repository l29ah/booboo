# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 git-r3

DESCRIPTION="Telegram MTProto API framework for users and bots"
HOMEPAGE="
	https://pypi.org/project/pyrogram/
"
EGIT_REPO_URI="https://github.com/pyrogram/pyrogram"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/pyaes[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest
		dev-python/pytest-asyncio
		dev-python/pytest-cov
	)
"

distutils_enable_tests pytest
