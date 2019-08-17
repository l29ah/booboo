# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib-minimal

DESCRIPTION="Stop the program on crash to allow attaching a debugger (like gdb)"
HOMEPAGE="https://github.com/l29ah/waitgdb"
EGIT_REPO_URI="https://github.com/l29ah/waitgdb"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_compile() {
	emake waitgdb.so
}

multilib_src_install() {
	emake libdir="${D}/usr/$(get_libdir)" install
}
