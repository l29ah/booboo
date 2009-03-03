# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Mail notification panel plugin"
HOMEPAGE="http://spuriousinterrupt.org/projects/mailwatch"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ssl"

RDEPEND="ssl? ( >=net-libs/gnutls-1.2 )"
DEPEND="dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable ssl)"
}

DOCS="AUTHORS ChangeLog NEWS README"
