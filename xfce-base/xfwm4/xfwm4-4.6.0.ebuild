# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Window manager"
HOMEPAGE="http://www.xfce.org/projects/xfwm4/"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="debug startup-notification xcomposite"

RDEPEND=">=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.10:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXpm
	x11-libs/pango
	>=x11-libs/libwnck-2.12
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	startup-notification? ( x11-libs/startup-notification )
	xcomposite? ( x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXfixes )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" --enable-xsync --enable-render --enable-randr
	$(use_enable xcomposite compositor)"
}

DOCS="AUTHORS ChangeLog COMPOSITOR NEWS README TODO"
