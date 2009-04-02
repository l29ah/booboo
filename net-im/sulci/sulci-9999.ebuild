# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit subversion

ESVN_REPO_URI="http://home.ermine.pp.ru/svn/ocaml/trunk/"

DESCRIPTION="Sulci is a free (GPL) Jabber bot that provides functionalities for
individuals and chatrooms, written by Anastasia Gornostaeva on Ocalm"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$RDEPEND"
RDEPEND="
		>=dev-lang/ocaml-3.10.2
		>=dev-ml/findlib-1.1.2
		>=sys-libs/zlib-1.2.3
		>=dev-ml/cryptokit-1.3
		>=dev-libs/libpcre-7.1
		>=dev-ml/pcre-ocaml-5.11.2
		>=dev-ml/ulex-1.0
		>=dev-ml/ocamlnet-2.2.9
		>=dev-db/sqlite-3.6.10
		>=dev-ml/ocaml-sqlite3-1.2.0
		sys-libs/gdbm
"
src_compile()
{
	make || die "make failed"
}

src_install()
{
	dodir /opt/sulci
	insinto /opt/sulci
	doins -r sulci/*
	fperms +x /opt/sulci/sulci
	dobin /opt/sulci/sulci
}

pkg_postinst()
{
	einfo "Sulci help"
	einfo "http://home.ermine.pp.ru/svn/ocaml/trunk/doc/sulci/cmdlist.ru.txt"
	einfo "Now create your own config like /opt/sulci/sulci.conf.example"
	einfo "When you make your own config you can run sulci like this"
	einfo "'# cd /opt/sulci && ./sulcu &' or '# sulci'"
	einfo "If you have some troubles with sulci - read '/opt/sulci/report.log'"
}
