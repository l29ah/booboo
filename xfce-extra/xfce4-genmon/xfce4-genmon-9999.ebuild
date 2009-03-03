# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Generic monitor panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-util/intltool"

src_unpack() {
	xfce4_src_unpack
	echo "glade/config_gui.glade" >> "${S}"/po/POTFILES.in
}

DOCS="AUTHORS ChangeLog NEWS README"
