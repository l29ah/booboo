# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit xfce4

xfce4_core

DESCRIPTION="a GTK+ based and advanced archive manager for use with Thunar"
HOMEPAGE="http://squeeze.xfce.org"
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd"
IUSE=""

#RDEPEND="dev-libs/dbus-glib
#        x11-libs/gtk+:2
#        >=xfce-base/libxfce4util-${XFCE_VERSION}
#        >=xfce-base/thunar-${XFCE_VERSION}"

RDEPEND="dev-libs/dbus-glib
	x11-libs/gtk+:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/thunar-1.0.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/gtk-doc"

WANT_GTKDOCIZE="yes"

src_compile() {
        ./autogen.sh
        emake || die "emake failed."
}

src_install() {
        emake DESTDIR="${D}" install || die "emake install failed."
        dodoc AUTHORS ChangeLog NEWS TODO
}

pkg_postinst() {
        fdo-mime_desktop_database_update
        fdo-mime_mime_database_update
        gnome2_icon_cache_update
}

pkg_postrm() {
        fdo-mime_desktop_database_update
        fdo-mime_mime_database_update
        gnome2_icon_cache_update
}
