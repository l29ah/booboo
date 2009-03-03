# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="xfce4-${PN}"
inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Command line panel plugin"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug"

RDEPEND=">=xfce-extra/exo-0.3.2
	dev-libs/libpcre
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
