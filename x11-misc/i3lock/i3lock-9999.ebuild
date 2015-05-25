# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3lock/i3lock-2.5.ebuild,v 1.4 2013/12/07 13:02:47 johu Exp $

EAPI=5

inherit git-2 toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="http://i3wm.org/i3lock/"
EGIT_REPO_URI="git://github.com/lexszero/i3lock"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/pam
	dev-libs/libev
	>=x11-libs/libxkbcommon-0.3.1
	x11-libs/libxkbfile
	x11-libs/xcb-util
	x11-libs/libX11
	x11-libs/cairo[xcb]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
DOCS=( CHANGELOG README.md )

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i -e 's:login:system-auth:' ${PN}.pam || die
	epatch_user
}

src_install() {
	default
	doman ${PN}.1
}
