# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_core

DESCRIPTION="Frontend for printing, management and job queue."
HOMEPAGE="http://www.xfce.org/projects/xfprint"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="cups doc debug"

RDEPEND="app-text/a2ps
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	cups? ( net-print/cups )
	!cups? ( net-print/lprng )"
DEPEND="${RDEPEND}
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	use cups || XFCE_CONFIG+=" --enable-bsdlpr"
	use cups && XFCE_CONFIG+=" --enable-cups"
	XFCE_CONFIG+=" $(use_enable doc gtk-doc)"
}

src_unpack() {
	xfce4_src_unpack
	sed -i -e "/24x24/d" "${S}"/icons/Makefile.in
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
