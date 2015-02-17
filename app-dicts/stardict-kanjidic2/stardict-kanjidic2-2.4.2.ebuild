# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-jmdict-ja-en/stardict-jmdict-ja-en-2.4.2-r1.ebuild,v 1.5 2009/01/23 13:18:44 pva Exp $

FROM_LANG="Japanese"
TO_LANG="English"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="http://dump.bitcheese.net/files/oxicece/stardict-kanjidic2-2.4.2.tar.bz2"

LICENSE="GDLS"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	cd ${P}
	stardict_src_install
	dodoc README
}
