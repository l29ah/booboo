# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils subversion

DESCRIPTION="Bitcoin is a peer-to-peer network based digital currency.
Peer-to-peer (P2P) means that there is no central authority to issue new money or keep track of transactions. Instead, these tasks are managed collectively by the nodes of the network."
HOMEPAGE="http://www.bitcoin.org/"
ESVN_REPO_URI="https://bitcoin.svn.sourceforge.net/svnroot/bitcoin/trunk"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/wxGTK:2.9
	sys-libs/db:4.8
	dev-libs/openssl
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "$FILESDIR/$P-Makefile.patch" # Not the best way to deal with	changing stuff; /r/ some sed mage
	ln -s makefile.unix Makefile
}

src_compile() {
	emake
}

src_install() {
	dobin bitcoin
}

