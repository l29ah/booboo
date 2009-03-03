# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

XFCE_VERSION="4.5.92"

DESCRIPTION="Xfce4 notification daemon"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfce4-notifyd"
SRC_URI="http://spuriousinterrupt.org/files/${PN}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE="debug libsexy"

RDEPEND="dev-libs/dbus-glib
	gnome-base/libglade
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	libsexy? ( x11-libs/libsexy )"
DEPEND="${RDEPEND}
	dev-util/intltool"

XFCE_CONFIG=" $(use_enable libsexy) --enable-maintainer-mode"

DOCS="AUTHORS ChangeLog NEWS README TODO"
