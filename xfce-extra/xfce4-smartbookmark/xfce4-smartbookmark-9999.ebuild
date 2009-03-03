# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Xfce panel smart-bookmark plugin"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=xfce-base/xfce-utils-${XFCE_VERSION}"

src_unpack() {
	xfce4_src_unpack
	sed -i -e 's:bugs.debian:bugs.gentoo:g' src/smartbookmark.c \
		|| die "sed failed"
}

DOCS="AUTHORS ChangeLog NEWS README"
