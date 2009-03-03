# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Calendar suite for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/orage/"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="berkdb dbus debug libnotify"

RDEPEND=">=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_VERSION}
	berkdb? ( >=sys-libs/db-4 )
	libnotify? ( x11-libs/libnotify )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable dbus) $(use_enable libnotify)
	$(use_with berkdb bdb4) --disable-libxfce4mcs"
}

pkg_postinst() {
	xfce4_pkg_postinst

	elog
	elog "There is no migration support from 4.4 to 4.5,"
	elog "you need to copy your Orage files manually."
	elog
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
