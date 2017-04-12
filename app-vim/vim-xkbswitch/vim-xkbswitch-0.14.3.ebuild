# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit vim-plugin

DESCRIPTION="easily switch current keyboard layout when entering and leaving Insert mode"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4503"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=25033
	-> $P.tgz"
LICENSE=""
KEYWORDS="alpha amd64 ia64 mips ppc ppc64 sparc x86"
IUSE=""
RDEPEND="x11-apps/xkb-switch"
S="$WORKDIR"
