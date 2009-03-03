# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils xfce4

xfce4_goodies

DESCRIPTION="Task Manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-taskmanager"

RDEPEND=">=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/libxfce4util-${XFCE_VERSION}"

src_install() {
	xfce4_src_install
	make_desktop_entry ${PN} "Task Manager" xfce-system-settings "Application;System;Utility;Core;GTK"
}

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
