# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
XFCE_VCS="git"
XFCE_CAT="kelnos"

inherit xfce4

DESCRIPTION="a gobject-based wrapper for libhal and libhal-storage"
HOMEPAGE="http://www.xfce.org/"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.6.0
	>=dev-libs/dbus-glib-0.7.0
	>=sys-apps/hal-0.5.7.1
	>=xfce-extra/exo-0.3.2[hal]"

DOCS="AUTHORS ChangeLog NEWS README"
