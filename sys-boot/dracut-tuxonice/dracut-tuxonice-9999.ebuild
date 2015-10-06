# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jq/jq-1.4.ebuild,v 1.2 2014/12/11 07:32:54 radhermit Exp $

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="TuxOnIce module for dracut."
HOMEPAGE="https://github.com/milo000/dracut-tuxonice"
EGIT_REPO_URI="git://github.com/milo000/dracut-tuxonice.git"
SRC_URI=""

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-kernel/dracut"

src_install() {
	insinto /usr/lib/dracut/modules.d/
	doins -r 95tuxonice
}
