# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Basic utilities library"
HOMEPAGE="http://www.xfce.org/projects/libraries"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2.6:2"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable doc gtk_doc)"
}

DOCS="AUTHORS ChangeLog NEWS README README.Kiosk THANKS TODO"
