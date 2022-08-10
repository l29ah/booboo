# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Generic CAM is an open source tool path generator for CNC machines."
HOMEPAGE="http://genericcam.sourceforge.net/"
EGIT_REPO_URI="https://git.code.sf.net/p/genericcam/git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	|| ( x11-libs/wxGTK:3.0 x11-libs/wxGTK:2.8 )
	media-libs/portmidi
	dev-lang/lua"
RDEPEND="${DEPEND}"

# to have an easier time installing it afterwards
CMAKE_IN_SOURCE_BUILD=yeah

src_prepare() {
	sed -i -e 's/lua5\.1/lua/;s/GLU/& GL/;s/xml/html &/' CMakeLists.txt
	cmake_src_prepare
}

src_install() {
	dobin genericcam
	dodir /usr/share/genericcam
	insinto /usr/share/genericcam
	doins -r machines examples
}
