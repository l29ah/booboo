# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/plan9port/plan9port-20080130.ebuild,v 1.1 2008/03/11 13:03:53 coldwind  Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Plan 9 From User Space"
HOMEPAGE="http://swtch.com/plan9port/"
SRC_URI="http://swtch.com/plan9port/${P}.tgz"

LICENSE="9base"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="X ( x11-apps/xauth ) "
RDEPEND="${DEPEND}"

S="${WORKDIR}/plan9"

PLAN9=/usr/lib/plan9

# P9P's man does not handle compression
PORTAGE_DOCOMPRESS=()

src_configure()
{
	# Fix paths, done in place of ./INSTALL -c
	einfo "Fixing hard-coded /usr/local/plan9 paths"
	find -type f -exec sed -i "s!/usr/local/plan9!${PLAN9}!g" "{}" ";"
}

src_prepare()
{
	epatch "${FILESDIR}/${PN}-"{9660srv-errno,no-lex,noexecstack}".patch"
}

src_compile() {
	# Convert -j5 to NPROC=5 for mk
	export NPROC="$(echo "$MAKEOPTS" | sed -r -n 's/.*(^| )-j([0-9]*).*/\2/p')"

	# The INSTALL script builds mk then [re]builds everything using that
	einfo "Compiling Plan 9 from User Space can take a very long time"
	einfo "depending on the speed of your computer. Please be patient!"
	./INSTALL -b || die "Build failed"
}

src_install() {
	dodir "${PLAN9}"

	# do* plays with the executable bit, and we should not modify them
	cp -a * "${D}/${PLAN9}"

	# build the environment variables and install them in env.d
	cat > "${T}/30plan9" <<-EOF
		PLAN9="${PLAN9}"
		PATH="${PLAN9}/bin"
		ROOTPATH="${PLAN9}/bin"
		MANPATH="${PLAN9}/man"
	EOF
	doenvd "${T}/30plan9"
}

pkg_postinst() {
	elog "Plan 9 from User Space has been successfully installed into"
	elog "${PLAN9}. Your PLAN9 and PATH environment variables have"
	elog "also been appropriately set, please use env-update and"
	elog "source /etc/profile to bring that into immediate effect."
	elog
	elog "Please note that ${PLAN9}/bin has been appended to the"
	elog "*end* or your PATH to prevent conflicts. To use the Plan9"
	elog "versions of common UNIX tools, use the absolute path:"
	elog "${PLAN9}/bin or the 9 command (eg: 9 troff)"
	elog
	elog "Please report any bugs to bugs.gentoo.org, NOT Plan9Port."
}
