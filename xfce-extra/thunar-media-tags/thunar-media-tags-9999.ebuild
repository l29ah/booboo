# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_thunar_plugin

DESCRIPTION="Thunar media tags plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/taglib-1.4"

DOCS="AUTHORS ChangeLog NEWS README TODO"
