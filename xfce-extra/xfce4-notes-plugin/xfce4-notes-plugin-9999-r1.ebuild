# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
inherit xfce4
 
xfce4_panel_plugin
 
DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
 
DEPEND=">=dev-lang/vala-0.5.7
	>=xfce-extra/xfce4-vala-0.1_rc"
 
DOCS="AUTHORS ChangeLog NEWS README TODO"
