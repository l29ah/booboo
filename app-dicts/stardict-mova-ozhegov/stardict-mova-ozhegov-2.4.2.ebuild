# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DICT_PREFIX="dictd_www.mova.org_"
DICT_SUFFIX=ozhegov

inherit stardict

SRC_URI="http://abloz.com/huzheng/stardict-dic/mova.org/${DICT_P}.tar.bz2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
