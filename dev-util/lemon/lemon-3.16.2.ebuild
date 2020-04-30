# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A LALR(1) parser generator"
HOMEPAGE="https://www.hwaci.com/sw/lemon/"
SRC_PV="$(printf "%u%02u%02u%02u" $(ver_rs 1- " "))"
SRC_URI="https://sqlite.org/2017/sqlite-src-${SRC_PV}.zip"

LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

PATCHES=( "${FILESDIR}/${PN}-3.6.23.1_gentoo.patch" )

S="${WORKDIR}/sqlite-src-${SRC_PV}/tool"

src_compile() {
	"$(tc-getCC)" -Wall -o lemon lemon.c || die
}

src_install() {
	insinto "/usr/share/lemon/"
	doins lempar.c
	dobin lemon
}
