# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3 autotools

DESCRIPTION="Ayfly is a AY-891x emulator and player."
HOMEPAGE="https://github.com/l29ah/ayfly"
EGIT_REPO_URI="https://github.com/l29ah/ayfly"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="wxwidgets"

RDEPEND="wxwidgets? ( x11-libs/wxGTK )"
DEPEND="$RDEPEND
	media-libs/libsdl
	sys-devel/automake"


src_prepare() {
	default
	use arm && epatch ${FILESDIR}/disable_filters.patch
	eautoreconf
}

src_configure() {
	local myconf
	use wxwidgets || myconf+=" --without-gui"
	econf $myconf
}
