# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DICT_P="$P"
FROM_LANG=English/Czech
TO_LANG=Czech/English

inherit stardict

HOMEPAGE="https://cs.cihar.com/software/slovnik/"
SRC_URI="http://dl.cihar.com/slovnik/stable/${DICT_P}.tar.gz"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
