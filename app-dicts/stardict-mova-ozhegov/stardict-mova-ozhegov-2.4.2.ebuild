# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DICT_PREFIX="dictd_www.mova.org_"

inherit stardict

SRC_URI="https://ftp.tw.freebsd.org/distfiles/stardict/${DICT_P}.tar.bz2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
