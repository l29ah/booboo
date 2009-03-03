# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Panel plugin to support GNOME applets"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"
