# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Battery status panel plugin"
KEYWORDS="~amd64 ~arm ~ppc ~x86" # ~x86-fbsd"
IUSE="debug"

DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"
