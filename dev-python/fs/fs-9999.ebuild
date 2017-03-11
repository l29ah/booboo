# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Python's Filesystem abstraction layer"
HOMEPAGE="https://github.com/PyFilesystem/pyfilesystem2"
EGIT_REPO_URI="https://github.com/PyFilesystem/pyfilesystem2"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
dev-python/six"

src_prepare() {
	# https://code.google.com/p/pyfilesystem/issues/detail?id=186
	sed -i -e 's#    def setcontents(self, path, file, chunk_size=64\*1024):#    def setcontents(self, path, file, chunk_size=64*1024, errors=None, encoding=None, encodings=None):#' fs/contrib/tahoelafs/__init__.py

	# https://code.google.com/p/pyfilesystem/issues/detail?id=194
	sed -i -e 's#            setattr(st, key, val)#            try:\n                setattr(st, key, val)\n            except:\n                pass#' fs/expose/fuse/fuse3.py
}
