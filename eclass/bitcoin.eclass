# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools-utils

DESCRIPTION="Bitcoin is a peer-to-peer network based digital currency.
Peer-to-peer (P2P) means that there is no central authority to issue new money or keep track of transactions. Instead, these tasks are managed collectively by the nodes of the network."
HOMEPAGE="http://www.bitcoin.org/"
if [[ "${PV}" == "9999" ]]; then
	ESVN_REPO_URI="https://bitcoin.svn.sourceforge.net/svnroot/bitcoin/trunk"
	inherit subversion
else
	SRC_URI="mirror://sourceforge/project/$PN/Bitcoin/$P/$P-linux.tar.gz"
	S="$WORKDIR/$P/src"
fi

LICENSE=""
SLOT="0"
IUSE=""

DEPEND="x11-libs/wxGTK:2.9
	sys-libs/db:4.8
	dev-libs/openssl
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

bitcoin_src_prepare() {
	epatch "$FILESDIR/$PN-${PATCH_VERSION:-$PV}-Makefile.patch" # Not the best way to deal with	changing stuff; /r/ some sed mage
	ln -s makefile.unix Makefile
}

bitcoin_src_compile() {
	base_src_compile
}

bitcoin_src_install() {
	dobin bitcoin || die dobin failed
}

EXPORT_FUNCTIONS src_prepare src_compile src_install

