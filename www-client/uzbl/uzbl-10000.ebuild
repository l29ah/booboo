# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"
EGIT_BRANCH="experimental"

DESCRIPTION="Uzbl: A UZaBLe Keyboard-controlled Lightweight Webkit-based Web Browser"
HOMEPAGE="http://www.uzbl.org/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="extras"

RDEPEND=">=net-libs/webkit-gtk-1.1.4
	 >=x11-libs/gtk+-2.14
	extras? ( gnome-extra/zenity x11-misc/dmenu )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die 'make install failed'
	dodoc AUTHORS README
}
