# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base git

DESCRIPTION="dealing with registers of nvidia cards"
HOMEPAGE="http://github.com/pathscale/pscnv/wiki/Introductorycourse"
EGIT_REPO_URI="git://0x04.net/pgtest"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND="${DEPEND}"

src_install() {
	# Lacks "watch" binary because of the naming conflict
	for b in peek poke mppeek lmppeek strand strscan mpscan lmpscan timer \
	bitscan strseek statwatch 3peek 3poke scan 3scan cscan pgpeek pgsub dsub \
	peekfb peekfc pokefb peekin;
	do
		mv "$b" "pgtest-$b"
		dobin "pgtest-$b"
	done
}
