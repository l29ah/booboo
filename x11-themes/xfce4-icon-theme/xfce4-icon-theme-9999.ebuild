# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_core

DESCRIPTION="Icon theme"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
RESTRICT="binchecks strip"

RDEPEND="x11-themes/hicolor-icon-theme"
DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
