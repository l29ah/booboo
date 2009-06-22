# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /CVS/anonCVS/psycmuve-beta-2/config/gentoo/ldmud.ebuild,v 1.17 2007/04/06 13:35:03 lynx Exp $
#
# In a philosophical way, LDMUD is a game engine, but from an administrative
# aspect it is a major project which doesn't belong into /usr/games. Especially
# not when it is actually serving as a programming language for intense
# multi-user network applications such as psyced. This is why we intentionally
# do not use any "games" macros here. Please keep it that way.  -lynX 2006
#
# Suggestions? tell psyc://psyced.org/~lynX
#
# WARNING/REMINDER to myself: When checking in a new version of this file
# into CVS I have to run 'make up' in the gentoo download tar, as it also
# relinks all the ldmud/ldmud-VERSION.ebuild files. 'cvs update' alone
# wouldn't do that.

inherit toolchain-funcs eutils

DESCRIPTION="LPMUD Driver for Multi-User Domains and LPC language implementation"
HOMEPAGE="http://www.bearnip.com/lars/proj/ldmud.html"

# using the filename of the ebuild here!
# so better give it numbers which are actually
# available on http://www.bearnip.com/ftp/mud/
SRC_URI="http://www.bearnip.com/ftp/mud/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# haven't checked for real..
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

src_unpack() {
		unpack ${A}
		#	cd "${S}"
		cd "${MYS}"
		# without "" or it won't ungrok the *.* -- thx fish
		cp ${FILESDIR}/erq/*.* util/erq || die "improved erq not found in ${FILESDIR}"
		cp "${FILESDIR}/psyced.settings" settings/psyced-gentoo || die "psyced.settings not found in ${FILESDIR}"
		chmod +x settings/psyced-gentoo
}

src_compile() {
		#	emake \
		#		CC="$(tc-getCC)" \
		#		CFLAGS="${CFLAGS}" ${PN} \
		#		|| die "emake failed"
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
			RESTRICT="${RESTRICT} nostrip"
			myopts="${myopts} --enable-debug"
		}
		# runs configure
		echo ${myopts}
		settings/psyced-gentoo ${myopts}
		make all && (cd "util/" && make subs) || die "make failed"
}

src_install () {
		cd "${MYS}"
		dosbin ${PN} && (cd "util/erq/" && dosbin "erq") || die "dosbin failed"
		cd "${MYS}/.."
		dodoc README HISTORY
		# do something about the files in the doc directory?
		# everyone looks stuff up on google anyway
		# but maybe we should install etc/lpc.vim?
}
