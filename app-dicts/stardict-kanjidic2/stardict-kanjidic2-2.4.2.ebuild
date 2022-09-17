# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FROM_LANG="Japanese"
TO_LANG="English"
DICT_P="$P"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="http://download.huzheng.org/ja/stardict-kanjidic2-2.4.2.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
