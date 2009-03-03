# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils xfce4

xfce4_panel_plugin

DESCRIPTION="Netload panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="dev-util/intltool"

XFCE4_PATCHES="${FILESDIR}/${PN}-0.4.0-asneeded.patch"

DOCS="AUTHORS ChangeLog NEWS README"
