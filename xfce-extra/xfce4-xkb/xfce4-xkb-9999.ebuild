# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="XKB layout switching panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libxklavier-3.2"
DEPEND="${DEPEND}
	dev-util/intltool
	x11-proto/kbproto"

DOCS="AUTHORS ChangeLog NEWS README"
