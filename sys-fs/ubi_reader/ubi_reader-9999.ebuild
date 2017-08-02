# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Collection of Python scripts for reading information about and extracting data from UBI and UBIFS images."
HOMEPAGE="https://github.com/jrspruitt/ubi_reader"
EGIT_REPO_URI="https://github.com/jrspruitt/ubi_reader"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/python-lzo[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
