# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_REPO_URI="git://gitorious.org/ac100/abootimg.git"
DESCRIPTION="Manipulate boot images for the Android bootloader"
SRC_URI=""
HOMEPAGE="http://android.git.kernel.org/?p=platform/system/core.git;a=summary"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND="sys-devel/gcc"

inherit git-r3

src_compile () {
    emake || die 'make failed.'
}

src_install() {
    dobin abootimg
}
