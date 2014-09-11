# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="florb is a really simple map viewer and GPX editor written in C++ using the FLTK UI toolkit."
HOMEPAGE="http://florb.shugaa.de/"
EGIT_REPO_URI='https://github.com/shugaa/florb/'

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/omake"
RDEPEND="
	dev-libs/tinyxml2
	x11-libs/fltk
	sci-geosciences/gpsd[cxx]
	>=dev-cpp/yaml-cpp-0.5.0
	dev-libs/boost
	net-misc/curl
	x11-libs/libXpm"

src_compile() {
	cd src
	omake --force-dotomake || die
}

src_install() {
	cd src
	omake --force-dotomake PREFIX="${D}/usr" install || die
}
