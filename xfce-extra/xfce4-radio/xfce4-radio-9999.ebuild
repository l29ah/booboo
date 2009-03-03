# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/intltool"

src_unpack() {
	xfce4_src_unpack
	echo "panel-plugin/radio.desktop.in.in" >> "${S}"/po/POTFILES.in
}

DOCS="AUTHORS NEWS README"
