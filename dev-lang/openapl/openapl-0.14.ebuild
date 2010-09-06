# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base

DESCRIPTION="OpenAPL is an open-source APL (A Programming Language) implementation. APL's strength is in the ease with which a programmer can manipulate arrays of numbers or characters."
HOMEPAGE="http://sourceforge.net/projects/openapl/"
SRC_URI="mirror://sourceforge/$PN/$P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	sys-devel/make
	sys-devel/gcc"
RDEPEND=""

S="$WORKDIR/openAPL"

src_install() {
	sed -i -re 's,/usr/share/man,$(mandir),;
		s,/usr/share,$(datadir),
		/dir|x11share/s,/usr,$(prefix),' Makefile
	einstall keytabledir=$D/usr/share/keymaps/i386/qwerty/ || die "install failed"
}
