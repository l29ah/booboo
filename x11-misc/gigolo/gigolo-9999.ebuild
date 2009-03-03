# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit xfce4

xfce4_goodies

DESCRIPTION="a frontend to easily manage connections to remote filesystems using
GIO/GVfs"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2"
RDEPEND="${DEPEND}"

src_install() {
	xfce4_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
