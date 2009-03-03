# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_goodies

DESCRIPTION="a lightweight BibTeX editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.12.0:2
	>=x11-libs/gtk+-2.10.0:2
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/libxfce4util-${XFCE_VERSION}"

DOCS="AUTHORS ChangeLog NEWS README TODO"
