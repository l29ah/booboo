# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Written by Takeshi KIRIYA (aka takeshik) <me@takeshik.org>.

EAPI=5

inherit flag-o-matic

DESCRIPTION="DHCP Client and Server originally developed by KAME Project"
HOMEPAGE="http://wide-dhcpv6.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/wide-dhcpv6/wide-dhcpv6/wide-dhcpv6-20080615/wide-dhcpv6-20080615.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vanilla"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	rm cfparse.c cftoken.c	# generated file
	epatch "${FILESDIR}/fix-libc-depend.patch"
	epatch "${FILESDIR}/fix-dprintf-conflict.patch"
	epatch "${FILESDIR}/address-suffix-1.patch"
	epatch "$FILESDIR/0002-Don-t-strip-binaries.patch"
	use vanilla || {
		epatch "$FILESDIR/0006-Add-new-feature-dhcp6c-profiles.patch"
		epatch "$FILESDIR/wide-dhcpv6-disable-extra-cflags.patch"
	}
	default
}

src_compile() {
	emake -j1
}

mkd() {
	local x=$1 X=$2 i=$3
	sed \
		-e "s:6x:6${x}:g" \
		-e "s:6X:6${X}:g" \
		"${FILESDIR}"/dhcp6x.${i}d.in > dhcp6${x}.${i}d
	new${i}d dhcp6${x}.${i}d dhcp6${x}
}

src_install() {
	einstall DESTDIR="${D}" || die
	mkd c R init
	mkd c R conf
	mkd r R init
	mkd r R conf
	mkd s S init
	mkd s S conf
	insinto /etc/wide-dhcpv6
	newins dhcp6c.conf.sample dhcp6c.conf
	newins dhcp6s.conf.sample dhcp6s.conf
}
