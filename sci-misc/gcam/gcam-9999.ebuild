# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gcam/gcam-9999.ebuild,v 1.3 2012/11/19 15:51:40 kensington Exp $

EAPI=5

EGIT_REPO_URI="https://github.com/blinkenlight/GCAM"

inherit autotools base git-r3

DESCRIPTION="GCAM Special Edition - 2.5D CAD/CAM with G-code output"
HOMEPAGE="https://github.com/blinkenlight/GCAM"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libxml2
	>=media-libs/libpng-1.5
	virtual/opengl
	virtual/glu
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/gtkglext
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# make it respect CFLAGS
	sed -i -e 's,-O[0-9],,' configure.ac
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf --enable-static=no
}

src_install() {
	default
	prune_libtool_files
}
