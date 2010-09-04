# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit base

DESCRIPTION="owl means Obfuscated Weird Language, and it's my main project
regarding obfuscated programming languages. It was born from the ashes of
bogusforth (another older language of mine, not longer maintained), but it's a
different thing. Its foundations are simplicity, strength and power."
HOMEPAGE="http://digilander.libero.it/tonibinhome/owl/"
MY_P="$PN.$PV.src"
SRC_URI="http://digilander.libero.it/tonibinhome/$PN/distrib/$MY_P.tgz"

S="$WORKDIR/$MY_P"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-devel/gcc-4.4.0"
RDEPEND=""

src_prepare() {
	# No man page in the distro; fix paths
	sed -i -e 's|\(INSTALLDIR=\).*|\1${DESTDIR}/usr/bin|;
		s|\(MANINSTALLDIR=\).*|\1${DESTDIR}/usr/share/man/man1|;
		/install:/a\\tmkdir -p $(INSTALLDIR) $(MANINSTALLDIR)
		/$(MANSOURCES) $(MANINSTALLDIR)/D' Makefile
}
