# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit base

DESCRIPTION="Markdown provides a library that gives you formatting functions
suitable for marking down entire documents or lines of text, a command-line program that you can use to mark down documents interactively or from a script, and a tiny (1 program so far) suite of example programs that show how to fully utilize the markdown library."
HOMEPAGE="http://www.pell.portland.or.us/~orc/Code/discount/"
SRC_URI="http://www.pell.portland.or.us/~orc/Code/discount/$P.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

src_configure() {
	./configure.sh
	sed -i -e 's#/usr/local#/usr#;
		/install:/a\\tmkdir -p $(DESTDIR)/$(BINDIR) $(DESTDIR)/$(MANDIR)/man{1,3,7} $(DESTDIR)/$(LIBDIR) $(DESTDIR)/$(INCDIR)'  Makefile
}
