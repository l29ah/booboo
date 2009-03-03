# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Collection of utils"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils/"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug +lock"

RDEPEND="x11-apps/xrdb
	x11-libs/libX11
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	dbus? ( dev-libs/dbus-glib )
	lock? ( || ( x11-misc/xscreensaver
		gnome-extra/gnome-screensaver
		x11-misc/xlockmore ) )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable dbus) --with-vendor-info=Gentoo"
}

src_install() {
	xfce4_src_install

	insinto /usr/share/xfce4
	doins "${FILESDIR}/Gentoo"

	dodir /etc/X11/Sessions
	echo startxfce4 > "${D}/etc/X11/Sessions/Xfce4"
	fperms 755 /etc/X11/Sessions/Xfce4
}

pkg_postinst() {
	elog
	elog "Run Xfce4 from your favourite Display Manager by using"
	elog "XSESSION=\"Xfce4\" in /etc/rc.conf"
	elog
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
