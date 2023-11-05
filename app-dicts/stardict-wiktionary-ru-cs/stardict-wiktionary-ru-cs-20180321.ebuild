# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DICT_P="wiktionary_ru-cs_stardict_2018-03-21"
FROM_LANG=Russian
TO_LANG=Czech

inherit stardict

HOMEPAGE="http://libredict.org/"
SRC_URI="http://www.libredict.org/dictionaries/ru-cs/${DICT_P}.tgz"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="+gzip"

S="$WORKDIR/Wiktionary Russian-Czech/"
