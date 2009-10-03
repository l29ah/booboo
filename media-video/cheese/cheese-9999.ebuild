# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

#GCONF_DEBUG="no"

inherit eutils git autotools

DESCRIPTION="A cheesy program to take pictures and videos from your webcam"
HOMEPAGE="http://www.gnome.org/projects/cheese/"
EGIT_REPO_URI="git://git.gnome.org/cheese"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="v4l"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.7
	>=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.14
	>=x11-libs/cairo-1.4.0
	>=x11-libs/pango-1.18.0
	>=sys-apps/dbus-1
	>=sys-apps/hal-0.5.9
	>=gnome-base/gconf-2.16.0
	>=gnome-base/gnome-desktop-2.25.1
	>=gnome-base/librsvg-2.18.0
	>=gnome-extra/evolution-data-server-1.12

	>=media-libs/gstreamer-0.10.16
	>=media-libs/gst-plugins-base-0.10.16"
RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-gconf-0.10
	>=media-plugins/gst-plugins-ogg-0.10.16
	>=media-plugins/gst-plugins-pango-0.10.16
	>=media-plugins/gst-plugins-theora-0.10.16
	>=media-plugins/gst-plugins-v4l2-0.10
	>=media-plugins/gst-plugins-vorbis-0.10.16
	v4l? ( >=media-plugins/gst-plugins-v4l-0.10 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	x11-proto/xf86vidmodeproto"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	eautoreconf
}
src_configure() {
	econf || die "configure failed"
}

src_install() {
	make install DESTDIR="${D}" docdir="${ROOT}/usr/share/doc/${PF}" \
		|| die "install failed"
}

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper --disable-hildon"
}
