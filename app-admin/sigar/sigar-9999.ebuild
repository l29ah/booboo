# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 autotools autotools-utils distutils-r1

DESCRIPTION="System Information Gatherer And Reporter"
HOMEPAGE="http://support.hyperic.com/display/SIGAR"
EGIT_REPO_URI="https://github.com/hyperic/sigar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="static-libs python"

RESTRICT="test"
DEPEND="python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"
RDEPEND=""

DOCS=(README)

# https://github.com/hyperic/sigar/issues/60
CFLAGS="$CFLAGS -fgnu89-inline"
CXXFLAGS="$CFLAGS -fgnu89-inline"

src_prepare() {
	sed -e '/netware/d' -i src/os/Makefile.am
	sed -e '/stub/d' -i src/os/Makefile.am
	sed -e '/osf1/d' -i src/os/Makefile.am
	eautoreconf
	if use python; then
		cd bindings/python
		distutils-r1_src_prepare
	fi
}

src_configure() {
	default_src_configure
	if use python; then
		cd bindings/python
		distutils-r1_src_configure
	fi
}

src_compile() {
	default_src_compile
	if use python; then
		cd bindings/python
		distutils-r1_src_compile
	fi
}
