# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

FROM_LANG="English"
TO_LANG="French"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://download.huzheng.org/Quick/"
SRC_URI="https://ftp.tw.freebsd.org/distfiles/stardict/${DICT_P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
