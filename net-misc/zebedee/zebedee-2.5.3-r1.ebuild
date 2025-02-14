# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A simple, free, secure TCP and UDP tunnel program"
HOMEPAGE="https://sourceforge.net/projects/zebedee/"
SRC_URI="https://downloads.sourceforge.net/zebedee/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ppc64 s390 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-libs/openssl
	sys-libs/zlib
	app-arch/bzip2"

src_prepare() {
	sed -i Makefile \
		-e '/^CFLAGS/s:=:+=:' \
		-e 's| -o zebedee| $(LDFLAGS)&|' \
		|| die "sed Makefile"

	# FIXME
	sed -i Makefile -e '/^all/{s/zebedee\.1//;s/zebedee\.html//;s/ftpgw\.tcl\.1//;s/ftpgw\.tcl\.html//;s/zebedee\.ja_JP\.html//}' || die

	default
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		BFINC=-I/usr/include/openssl \
		BFLIB=-lcrypto \
		ZINC=-I/usr/include \
		ZLIB=-lz \
		BZINC=-I/usr/include \
		BZLIB=-lbz2 \
		OS=linux || die
}

src_install() {
	#emake \
	#	ROOTDIR="${D}"/usr \
	#	MANDIR="${D}"/usr/share/man/man1 \
	#	ZBDDIR="${D}"/etc/zebedee \
	#	OS=linux \
	#	install || die
	#rm -f "${D}"/etc/zebedee/*.{txt,html}

	#dodoc *.txt
	#dohtml *.html

	dobin zebedee ftpgw.tcl
}

pkg_postinst() {
	echo
	einfo "Before you use the Zebedee rc script (/etc/init.d/zebedee), it is"
	einfo "recommended that you edit the server config file: "
	einfo "(/etc/zebedee/server.zbd)."
	einfo "the \"detached\" directive should remain set to false;"
	einfo "the rc script takes care of backgrounding automatically."
	echo
}
