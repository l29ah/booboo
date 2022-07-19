# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 cmake

DESCRIPTION="An open-source car navigation system with a routing engine"
HOMEPAGE="http://www.navit-project.org"
EGIT_REPO_URI="https://github.com/navit-gps/navit"
SRC_URI="https://patch-diff.githubusercontent.com/raw/navit-gps/navit/pull/647.patch -> $PN-647.patch"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus garmin gles gles2 gps gtk nls python qt sdl speechd +svg"

RDEPEND="dev-libs/glib:2
	dev-libs/protobuf-c
	garmin? ( dev-libs/libgarmin )
	gles? ( virtual/opengl )
	gles2? ( virtual/opengl )
	gtk? ( x11-libs/gtk+:2
		x11-misc/xkbd )
	qt? ( dev-qt/qtsensors:5 app-accessibility/espeak )
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

PATCHES=( "$DISTDIR/$PN-647.patch" )

src_configure() {
	mycmakeargs=(
		-DSAMPLE_MAP=OFF
		-DUSE_SVG=$(usex svg)
		-DUSE_OPENGLES=$(usex gles)
		-DUSE_OPENGLES2=$(usex gles2)
		-DUSE_NATIVE_LANGUAGE_SUPPORT=$(usex nls)
		-DDISABLE_QT=$(usex qt NO YES)
	)

	cmake_src_configure
}

src_install () {
	cmake_src_install

	dodoc AUTHORS CHANGELOG.md README.md || die "dodoc failed"
}
