# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-1.42.ebuild,v 1.4 2009/01/02 21:00:15 ssuominen Exp $

EAPI=2

inherit autotools eutils fdo-mime gnome2-utils subversion

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com"

ESVN_REPO_URI="svn://svn.m0k.org/Transmission/trunk"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND=">=dev-libs/openssl-0.9.4
|| ( >=net-misc/curl-7.16.3[ssl] >=net-misc/curl-7.16.3[gnutls] )
gtk? ( >=dev-libs/glib-2.15.5
>=x11-libs/gtk+-2.6
>=dev-libs/dbus-glib-0.70
libnotify? ( >=x11-libs/libnotify-0.4.4 ) )"
DEPEND="${RDEPEND}
sys-devel/gettext
dev-util/intltool
virtual/pkgconfig"

pkg_setup() {
	enewgroup transmission
	enewuser transmission -1 -1 "/var/lib/transmission" transmission
}

src_prepare() {
#	epatch "${FILESDIR}"/${P}-respect_flags.patch
	eautoreconf
}

src_configure() {
	local myconf="--disable-dependency-tracking --with-wx-config=no"
	
        ./autogen.sh
}

pkg_preinst() {
	gnome2_icon_savelist
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS
	rm -f "${D}"/usr/share/${PN}/web/LICENSE
	
	newinitd "${FILESDIR}"/${PN}.initd transmission-daemon
	newconfd "${FILESDIR}"/${PN}.confd transmission-daemon
	
	diropts -o transmission -g transmission -m0755
	keepdir /var/lib/transmission
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
