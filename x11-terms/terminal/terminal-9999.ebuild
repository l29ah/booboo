# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

MY_P="${P/t/T}"

DESCRIPTION="Terminal for Xfce desktop environment, based on vte library."
HOMEPAGE="http://www.xfce.org/projects/terminal"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug startup-notification doc"

RDEPEND=">=dev-libs/glib-2.6:2
	media-libs/fontconfig
	media-libs/freetype
	>=x11-libs/gtk+-2.10:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	>=x11-libs/vte-0.11.11
	>=xfce-extra/exo-0.3.4
	startup-notification? ( x11-libs/startup-notification )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/intltool
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable dbus) $(use_enable doc xsltproc)"
}

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
