# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="https://github.com/ggrandou/abootimg"
DESCRIPTION="Manipulate boot images for the Android bootloader"
HOMEPAGE="https://github.com/ggrandou/abootimg"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

inherit git-r3

src_install() {
	dobin abootimg
}
