# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils subversion

DESCRIPTION="Filesystem abstraction"
HOMEPAGE="http://code.google.com/p/pyfilesystem/"
ESVN_REPO_URI="http://pyfilesystem.googlecode.com/svn/trunk/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
dev-python/six"
