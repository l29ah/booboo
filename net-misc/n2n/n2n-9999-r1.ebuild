# Copyright 1999-2011 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils toolchain-funcs subversion user

DESCRIPTION="A Layer Two Peer-to-Peer VPN"
HOMEPAGE="http://www.ntop.org/n2n/"
ESVN_REPO_URI="https://svn.ntop.org/svn/ntop/trunk/n2n/n2n_v2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup n2n
	enewuser n2n -1 -1 /var/empty n2n
}

src_prepare() {
	sed -i \
		-e 's|$(CC) $(CFLAGS)|\0 $(LDFLAGS)|' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	DOCS="HACKING"
	default

	keepdir /var/log/n2n
	fowners n2n:n2n /var/log/n2n

	newconfd "${FILESDIR}/supernode.confd" supernode
	newinitd "${FILESDIR}/supernode.initd" supernode
	newconfd "${FILESDIR}/edge.confd" edge
	newinitd "${FILESDIR}/edge.initd" edge
}

