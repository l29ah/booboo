# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 fortran-2

DESCRIPTION="a benchmark that measures sustainable memory bandwidth and computation rate"
HOMEPAGE="https://www.cs.virginia.edu/stream/ref.html"
EGIT_REPO_URI="https://github.com/jeffhammond/STREAM/"

LICENSE="STREAM"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="virtual/fortran"

CFLAGS="$CFLAGS -fopenmp"

src_prepare() {
	sed -i -e '/^[FC]C =/d;/^CFLAGS =/d' Makefile
	default
}

src_compile() {
	export FC=$(tc-getFC)
	emake
}

src_install() {
	dobin stream_c.exe stream_f.exe
}
