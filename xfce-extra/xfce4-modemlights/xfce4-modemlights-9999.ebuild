# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="a panel plugin to turn dialup (ppp) connections on/off"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND=">=dev-libs/glib-2.8:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}"

DOCS="AUTHORS ChangeLog NEWS README"
