# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_thunar_plugin

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://code.google.com/p/thunar-shares/"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
