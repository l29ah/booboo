# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /CVS/anonCVS/psycmuve-beta-2/config/gentoo/psyclpc.ebuild,v 1.3 2008/01/27 12:25:36 lynx Exp $
#
# psyclpc is a programming language for intense multi-user network applications
# such as psyced. it's a recent fork of LDMud with some features and many
# bug fixes. we kept it compatible to LDMud, so you can run a MUD with it, too.
#
# Suggestions? tell psyc://psyced.org/~lynX
#
# WARNING/REMINDER to myself: When checking in a new version of this file
# into CVS I have to run 'make up' in the gentoo download tar, as it also
# relinks all the psyclpc/psyclpc-VERSION.ebuild files. 'cvs update' alone
# wouldn't do that.
#
# this ebuild file is available in both psyclpc/etc and psyced/config/gentoo.
# psyced also provides installation automations.

inherit toolchain-funcs eutils flag-o-matic

DESCRIPTION="psycLPC is a multi-user network server programming language"
HOMEPAGE="http://lpc.psyc.eu/"

# using the filename of the ebuild here!
# so better give it numbers which are actually
# available in http://www.psyced.org/files/
SRC_URI="http://www.psyced.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# haven't checked for real..
# but there have been non-gentoo ports to all platforms
KEYWORDS="x86 ~ppc ~amd64"
IUSE="debug ssl static zlib ldap ipv6 mysql postgres berkdb"

RDEPEND="zlib? ( sys-libs/zlib )
		ssl? ( dev-libs/openssl )
		ldap? ( net-nds/openldap )
		berkdb? ( sys-libs/db )
		mysql? ( dev-db/mysql )
		postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
		>=sys-devel/flex-2.5.4a-r5
		>=sys-devel/bison-1.875
		>=sys-devel/gettext-0.12.1"

#MYS="/var/tmp/portage/${P}/work/${P}/src"
MYS="${S}/src"

src_compile() {
		cd "${MYS}"
#		use berkdb >&/dev/null && myopts="${myopts} --enable-db"
#		use mysql >&/dev/null && myopts="${myopts} --enable-mysql" || myopts="${myopts} --disable-mysql"
#		use postgres >&/dev/null && myopts="${myopts} --enable-pgsql"
#		use ldap >&/dev/null && myopts="${myopts} --enable-ldap"
#		use ipv6 >&/dev/null && myopts="${myopts} --enable-ipv6"
		use zlib && {
			einfo "Compiling ${P} with zlib (MCCP) support."
			myopts="${myopts} --enable-use-mccp"
		}
		use ssl && {
			einfo "Compiling ${P} with SSL support."
			myopts="${myopts} --enable-use-tls=yes"
		}
		use mysql && {
			einfo "Compiling ${P} with mySQL support."
			myopts="${myopts} --enable-use-mysql"
		}
		use postgres && {
			einfo "Compiling ${P} with PostgreSQL support."
			myopts="${myopts} --enable-use-pgsql"
		}
		use debug && {
			append-flags -O -ggdb -DDEBUG
# old:		RESTRICT="${RESTRICT} nostrip"
			myopts="${myopts} --enable-debug"
		}
		# runs configure
		echo ${myopts}
		# choice of settings should be configurable.. TODO
		settings/psyced ${myopts}
		make all && (cd "util/" && make subs) || die "make failed"
}

src_install () {
		cd "${MYS}"
		dosbin ${PN} && (cd "util/erq/" && dosbin "erq") || die "dosbin failed"
		cd "${MYS}/.."
		# only the interesting files
		dodoc HELP CHANGELOG psyclpc.1
		# maybe we should install etc/lpc.vim?
		# and what about the man file?
}
