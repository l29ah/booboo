# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-5.4.ebuild,v 1.3 2007/08/13 21:22:10 dertobi123 Exp $

inherit eutils

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/thc-hydra/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="gtk ssl"

DEPEND="gtk? ( >=x11-libs/gtk+-1.2 )
	ssl? (
		dev-libs/openssl
		=net-libs/libssh-0.11
	)"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
        cd "${S}/hydra-gtk/src"
        epatch "${FILESDIR}/o_creat.patch"
	cd "${S}"
	sed -i "s:-O2:${CFLAGS}:" Makefile.am || die "sed failed"
}

src_compile() {
	if use gtk ; then
		./configure --prefix=/usr || die "configure failed"
	else
		./configure --prefix=/usr --disable-xhydra || die "configure failed"
	fi

	sed -i \
		-e '/^XDEFINES=/s:=.*:=:' \
		-e '/^XLIBS=/s:=.*:=:' \
		-e '/^XLIBPATHS/s:=.*:=:' \
		-e '/^XIPATHS=/s:=.*:=:' \
		Makefile || die "pruning vars"

	if use ssl ; then
		sed -i \
			-e '/^XDEFINES=/s:=:=-DLIBOPENSSL -DLIBSSH:' \
			-e '/^XLIBS=/s:=:=-lcrypto -lssl -lssh:' \
			Makefile || die "adding ssl"
	fi
	emake || die "make failed"

	if use gtk ; then
		cd hydra-gtk
		econf || die "econf hydra-gtk failed"
		emake || die "emake hydra-gtk failed"
	fi
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	if use gtk ; then
		dobin hydra-gtk/src/xhydra || die "gtk"
	fi
	dodoc CHANGES README TODO
}
