# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib scons-utils git-r3

DESCRIPTION="C! (cbang) is a library of cross-platform C++ utilities"
HOMEPAGE="https://github.com/CauldronDevelopmentLLC/cbang"

SRC_URI=""
EGIT_REPO_URI="https://github.com/CauldronDevelopmentLLC/cbang.git"

LICENSE="LGPL-2.1"
SLOT=0
KEYWORDS=""

IUSE="+ChakraCore v8"

# see https://github.com/CauldronDevelopmentLLC/cbang/issues/17
RDEPEND="
	dev-libs/boost
	ChakraCore? ( net-libs/ChakraCore )
	v8? ( <dev-lang/v8-3.15 )
"
DEPEND="${RDEPEND}
"

src_configure() {
	if use ChakraCore; then
		export CHAKRA_CORE_HOME="/opt/ChakraCore"
	fi
	MYSCONS=( -C ${S} )
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r ${S}/*
}
