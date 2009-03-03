# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Rewrite of GNOME Places menu for panel"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=xfce-base/thunar-1.0.0"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"
