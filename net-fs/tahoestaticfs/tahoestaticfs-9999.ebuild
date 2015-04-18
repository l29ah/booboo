# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Tahoestaticfs is a Fuse filesystem that enables read and write access to files stored on a Tahoe-LAFS grid."
HOMEPAGE="https://github.com/pv/tahoestaticfs"
EGIT_REPO_URI="https://github.com/pv/tahoestaticfs.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-python/fuse-python-0.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-0.5[${PYTHON_USEDEP}]
	>=dev-python/nose-1.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}] "
RDEPEND="${DEPEND}"
