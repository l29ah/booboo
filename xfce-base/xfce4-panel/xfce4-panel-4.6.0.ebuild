# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Panel"
HOMEPAGE="http://www.xfce.org/projects/xfce4-panel/"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="debug doc startup-notification"

RDEPEND=">=dev-libs/glib-2.8:2
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/gtk+-2.8:2
	>=x11-libs/libwnck-2.12
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-extra/exo-0.3.92
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable doc gtk-doc)"
}

DOCS="AUTHORS ChangeLog HACKING NEWS README README.Plugins"
