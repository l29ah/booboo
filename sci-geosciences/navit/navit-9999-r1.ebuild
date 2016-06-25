# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit subversion cmake-utils

DESCRIPTION="An open-source car navigation system with a routing engine"
HOMEPAGE="http://www.navit-project.org"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus garmin gles gles2 gps gtk nls python sdl speechd svg"

RDEPEND="dev-libs/glib:2
	garmin? ( dev-libs/libgarmin )
	gles? ( virtual/opengl )
	gles2? ( virtual/opengl )
	gtk? ( x11-libs/gtk+:2
		x11-misc/xkbd )
	sdl? ( media-libs/libsdl
		media-libs/sdl-image
		dev-games/cegui
		media-libs/quesoglc )
	python? ( dev-lang/python )
	dbus? ( sys-apps/dbus )
	gps? ( sci-geosciences/gpsd )
	speechd? ( app-accessibility/speech-dispatcher )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-vcs/cvs
	svg? ( || ( gnome-base/librsvg media-gfx/imagemagick[png,svg] ) )"

ESVN_REPO_URI="http://navit.svn.sourceforge.net/svnroot/navit/trunk/navit"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_use svg SVG)
		$(cmake-utils_use_use gles OPENGLES)
		$(cmake-utils_use_use gles2 OPENGLES2)
		$(cmake-utils_use_use nls NATIVE_LANGUAGE_SUPPORT)
	)

	cmake-utils_src_configure
}

src_install () {
	cmake-utils_src_install

	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
