# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit git-r3 python-r1

DESCRIPTION="Tool for partial deblobbing of Intel ME/TXE firmware images"
HOMEPAGE="https://github.com/corna/me_cleaner"
EGIT_REPO_URI="https://github.com/corna/me_cleaner"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=${PYTHON_DEPS}
REQUIRED_USE=${PYTHON_REQUIRED_USE}

src_install() {
	python_foreach_impl python_newscript "${PN}"{.py,}
	dodoc "README.md"
	doman "man/${PN}.1"
}
