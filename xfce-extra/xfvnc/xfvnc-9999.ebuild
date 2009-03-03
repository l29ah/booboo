# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_goodies

DESCRIPTION="Xfce4 VNC client"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/libglade
	net-libs/gnutls
	net-libs/gtk-vnc
	x11-libs/gtk+:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
