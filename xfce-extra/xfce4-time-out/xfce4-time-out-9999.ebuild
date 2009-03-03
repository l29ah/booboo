# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Panel plugin for taking break from computer work."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-lang/perl"

XFCE4_PATCHES="${FILESDIR}/${PN}-libtool22.patch"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
