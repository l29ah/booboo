# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="An open-source car navigation system with a routing engine"
HOMEPAGE="http://www.navit-project.org"
EGIT_REPO_URI="https://github.com/navit-gps/navit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus garmin gles gles2 gps gtk nls python qt sdl speechd svg"

RDEPEND="dev-libs/glib:2
	dev-libs/protobuf-c
	garmin? ( dev-libs/libgarmin )
	gles? ( virtual/opengl )
	gles2? ( virtual/opengl )
	gtk? ( x11-libs/gtk+:2
		x11-misc/xkbd )
	qt? ( dev-qt/qtsensors:5 )
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
	svg? ( || ( gnome-base/librsvg media-gfx/imagemagick[png,svg] ) )"

src_configure() {
	mycmakeargs=(
		-DSAMPLE_MAP=OFF
		$(cmake-utils_use_use svg SVG)
		$(cmake-utils_use_use gles OPENGLES)
		$(cmake-utils_use_use gles2 OPENGLES2)
		$(cmake-utils_use_use nls NATIVE_LANGUAGE_SUPPORT)
		$(cmake-utils_use_disable qt QT)
	)

	cmake-utils_src_configure
}

src_install () {
	cmake-utils_src_install

	dodoc AUTHORS CHANGELOG.md README.md || die "dodoc failed"
}
