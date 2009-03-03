# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="xfmedia panel plugin"
KEYWORDS="~amd64 ~x86"

IUSE="debug dbus"

RDEPEND="media-video/xfmedia
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable dbus) --enable-final"
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
