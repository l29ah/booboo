# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-1.33.ebuild,v 1.1 2008/09/04 23:51:43 compnerd Exp $

inherit autotools eutils

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/transmission/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk libnotify"

RDEPEND=">=dev-libs/glib-2.16
		 >=net-misc/curl-7.15.0
		 >=dev-libs/openssl-0.9.8
		 gtk? ( >=x11-libs/gtk+-2.6
				>=dev-libs/dbus-glib-0.72 )
		 libnotify? ( >=x11-libs/libnotify-0.4.4 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		gtk? ( >=dev-util/intltool-0.35 )"

src_compile() {
	econf $(use_enable gtk) $(use_enable libnotify) --with-wx-config=no || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS

	doinitd "${FILESDIR}/transmission-daemon"
}
