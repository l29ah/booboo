# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.7.3-r4.ebuild,v 1.1 2009/10/17 18:27:12 hwoarang Exp $

# the actual version is "NG-0.7.0" but I suppose portage people will not be
# happy with it (as for the 0.6.b version), so let's set it to "0.7.0".
# since 'ettercap NG' has to be intended as an upgrade to 0.6.x series and not as
# a new project or branch, this will be fine...

WANT_AUTOMAKE="1.8"

# libtool is needed because it provides libltdl (needed for plugins)
inherit autotools flag-o-matic libtool

MY_P="${PN}-NG-${PV}"
DESCRIPTION="A suite for man in the middle attacks and network mapping"
HOMEPAGE="http://ettercap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug gtk ncurses ssl"

RDEPEND=">=net-libs/libnet-1.1.2.1-r1
	net-libs/libpcap
	ncurses? ( sys-libs/ncurses )
	ssl? ( dev-libs/openssl )
	gtk? ( >=x11-libs/gtk+-2.2.2 )"
DEPEND=${RDEPEND}

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's:-Werror ::' -i configure.in
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-open_missing_mode.patch

	epatch "${FILESDIR}"/${P}-daemon-textmode.patch
 	epatch "${FILESDIR}"/${P}-daemon-ui.patch
 	epatch "${FILESDIR}"/${P}-mitm-loop.patch
 	epatch "${FILESDIR}"/${P}-selinux-fcntl.patch
 	epatch "${FILESDIR}"/${P}-UI.patch
	eautoreconf
}

src_compile() {
	strip-flags

	append-flags "-DLTDL_SHLIB_EXT='\".so\"'" #272681

	local myconf
	if use ssl; then
		myconf="${myconf} --with-openssl=/usr"
	else
		myconf="${myconf} --without-openssl"
	fi

	econf ${myconf} \
		$(use_enable gtk) \
		$(use_enable debug) \
		$(use_with ncurses)

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
