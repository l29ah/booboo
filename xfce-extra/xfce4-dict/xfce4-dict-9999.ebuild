# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_goodies

DESCRIPTION="Dict panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_VERSION}"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"
