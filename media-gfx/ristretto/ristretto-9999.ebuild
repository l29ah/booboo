# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_goodies

DESCRIPTION="a fast and lightweight picture-viewer for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/ristretto"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +xfce"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.12:2
	dev-libs/dbus-glib
	media-libs/libexif
	sys-apps/dbus
	>=xfce-base/thunar-${THUNAR_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	xfce? ( >=xfce-base/xfconf-${XFCE_VERSION} )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable xfce xfce-desktop)"
}

src_unpack() {
	xfce4_src_unpack
	echo "src/save_dialog.c" >> "${S}"/po/POTFILES.in
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
